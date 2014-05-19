class Realballerz.Views.TeamsShow extends Backbone.View

  template: JST['teams/show']

  events:
    'submit #add_new_player': 'addNewPlayer'
    'click #teams_index': 'teams_index'

  addNewPlayer: (event) ->
    event.preventDefault()
    new_player_id = $('#new_player_id').val()
    new_player_name = $("#new_player_id option[value=#{new_player_id}]").text()
    team_player = new Realballerz.Models.TeamPlayer(team_id: @id, player_id: new_player_id)
    team_player.save(
      {},
      wait: true
      success: =>
        alert("added player #{new_player_name} to #{@team.get('name')}")
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

