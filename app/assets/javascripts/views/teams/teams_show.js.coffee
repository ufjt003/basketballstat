class Realballerz.Views.TeamsShow extends Backbone.View

  template: JST['teams/show']

  events:
    'submit #add_new_player_form': 'addNewPlayer'
    'click #teams_index': 'teams_index'
    'click #remove_player': 'remove_player'

  remove_player: (event) ->
    event.preventDefault()
    player_id = event.target.getAttribute('data')
    removed_player = new Realballerz.Models.Player()
    removed_player.urlRoot = "/api/teams/#{@id}/remove_player/#{player_id}"
    removed_player.on('sync', @clearPlayer)
    removed_player.save(
      wait: true
      error: @handleError
    )

  initialize: (options) ->
    @collection.on('reset', @render)

  render: =>
    @team = @collection.get(@id)
    if @team != undefined
      $(@el).html(@template(team: @team))
      view = new Realballerz.Views.PlayersWithNoTeam(id: @id)
      $("#add_new_player_form").replaceWith(view.render().el)
    this

  teams_index: ->
    Backbone.history.navigate("teams", true)

  handleError: (entry, response) ->
    if response.status != 200
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  clearPlayer: (player) =>
    event.preventDefault()
    $("#player-tr-#{player.get('id')}").remove()
    s = "<option value=#{player.get('id')}>#{player.get('name')}</option>"
    $("#new_player_id").append(s)
    $("#add_new_player_form").show()
    alert("removed player #{player.get('name')}")

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

  appendPlayer: (player) =>
    view = new Realballerz.Views.Player(model: player)
    view.show_remove_link = true
    $('#players > tbody:last').append(view.render().el)
    alert("added player #{player.get('name')} to #{player.get('team_name')}")

  resetUnassignedPlayerList: (last_player) ->
    $("#new_player_id option[value=#{last_player.get('id')}]").remove()
    if $('#new_player_id > option').length == 0
      $("#add_new_player_form").hide()
