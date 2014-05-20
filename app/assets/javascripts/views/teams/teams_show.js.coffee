class Realballerz.Views.TeamsShow extends Backbone.View

  template: JST['teams/show']

  events:
    'submit #add_new_player_form': 'addNewPlayer'
    'click #teams_index': 'teams_index'

  addNewPlayer: (event) ->
    event.preventDefault()
    new_player_id = $('#new_player_id').val()
    team_player = new Realballerz.Models.Player()
    team_player.url = "/api/teams/#{@id}/add_player/#{new_player_id}"
    team_player.on('sync', @appendPlayer)
    team_player.on('sync', @resetUnassignedPlayerList)
    team_player.save(
      {},
      wait: true
      error: @handleError
    )

  initialize: (options) ->
    @players_with_no_team = options.players_with_no_team
    @collection.on('reset', @render)
    @players_with_no_team.on('reset', @render)

  render: =>
    @team = @collection.get(@id)
    if @team != undefined
      $(@el).html(@template(team: @team, players_with_no_team: @players_with_no_team))
    this

  teams_index: ->
    Backbone.history.navigate("teams", true)

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  appendPlayer: (player) =>
    view = new Realballerz.Views.Player(model: player)
    @$('#players > tbody:last').append(view.render().el)
    alert("added player #{player.get('name')} to #{player.get('team_name')}")

  resetUnassignedPlayerList: (last_player) ->
    $("#new_player_id option[value=#{last_player.get('id')}]").remove()
    length = $('#new_player_id > option').length
    if length == 0
      $("#add_new_player_form").remove()

