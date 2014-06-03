class Realballerz.Views.GamePlayers extends Backbone.View
  template: JST['games/game_players']

  events:
    'click .two_pointer_attempt': 'two_pointer_attempt'
    'click .two_pointer_make': 'two_pointer_make'
    'click .three_pointer_attempt': 'three_pointer_attempt'
    'click .three_pointer_make': 'three_pointer_make'
    'click .free_throw_attempt': 'free_throw_attempt'
    'click .free_throw_make': 'free_throw_make'
    'click .assist': 'assist'
    'click .block': 'block'
    'click .steal': 'steal'
    'click .rebound': 'rebound'
    'click .turnover': 'turnover'
    'click .foul': 'foul'

  initialize: (options) ->
    @set_home_team_players(this)
    @set_away_team_players(this)

  set_home_team_players: ->
    @home_team_players = new Realballerz.Collections.Players()
    @home_team_players.url = "/api/games/#{@id}/home_team_players"
    @home_team_players.on('reset', @update_home_team_players, this)
    @home_team_players.fetch({reset: true})

  set_away_team_players: ->
    @away_team_players = new Realballerz.Collections.Players()
    @away_team_players.url = "/api/games/#{@id}/away_team_players"
    @away_team_players.on('reset', @update_away_team_players, this)
    @away_team_players.fetch({reset: true})

  update_home_team_players: (players) ->
    players.each(@append_home_player)

  update_away_team_players: (players) ->
    players.each(@append_away_player)

  append_home_player: (player) ->
    view = new Realballerz.Views.PlayerAction(model: player)
    $('#home_players_in_game').append(view.render().el)

  append_away_player: (player) ->
    view = new Realballerz.Views.PlayerAction(model: player)
    $('#away_players_in_game').append(view.render().el)

  player_action: (event, action_name) ->
    event.preventDefault()
    player_id = event.target.getAttribute('data')
    player = new Realballerz.Models.Player(id: player_id)
    player.url = "/api/players/#{player_id}/#{action_name}"
    player.save(
      {},
      wait: true
      success: @update_player_stat
      error: @handleError
    )

  two_pointer_attempt: (event) ->
    @player_action(event, "two_pointer_attempt")

  two_pointer_make: (event) ->
    @player_action(event, "two_pointer_make")

  three_pointer_attempt: (event) ->
    @player_action(event, "three_pointer_attempt")

  three_pointer_make: (event) ->
    @player_action(event, "three_pointer_make")

  free_throw_attempt: (event) ->
    @player_action(event, "free_throw_attempt")

  free_throw_make: (event) ->
    @player_action(event, "free_throw_make")

  assist: (event) ->
    @player_action(event, "assist")

  block: (event) ->
    @player_action(event, "block")

  steal: (event) ->
    @player_action(event, "steal")

  rebound: (event) ->
    @player_action(event, "rebound")

  turnover: (event) ->
    @player_action(event, "turnover")

  foul: (event) ->
    @player_action(event, "foul")

  update_player_stat: (player) ->
    console.log(player.get('name'))

  render: =>
    $(@el).html(@template())
    this
