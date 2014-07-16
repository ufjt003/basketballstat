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
    'click .player_leave': 'player_leave'
    'click .player_enter': 'player_enter'

  initialize: (options) ->
    @collection.on('reset', @render)

  set_players: ->
    @players = new Realballerz.Collections.Players()
    @players.url = "/api/games/#{@id}/players"
    @players.on('reset', @update_players, this)
    @players.fetch({reset: true})

  update_players: (players) ->
    players.each(@append_player)

  append_player: (player) ->
    team_id = player.get('team_id')
    if player.get('playing_in_game')
      view = new Realballerz.Views.PlayerAction(model: player)
      $("#game_players_in_team_#{team_id}").append(view.render().el)
    else
      view = new Realballerz.Views.BenchPlayer(model: player)
      $("#bench_players_in_team_#{team_id}").append(view.render().el)

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

  player_enter: (event) ->
    event.preventDefault()
    player_id = event.target.getAttribute('data')
    player = new Realballerz.Models.Player(id: player_id)
    player.url = "/api/games/#{@id}/player_entry/#{player_id}"
    player.save(
      {},
      wait: true
      success: @player_entry_success
      error: @handleError
    )

  player_leave: (event) ->
    event.preventDefault()
    player_id = event.target.getAttribute('data')
    player = new Realballerz.Models.Player(id: player_id)
    player.url = "/api/games/#{@id}/player_leave/#{player_id}"
    player.save(
      {},
      wait: true
      success: @player_leave_success
      error: @handleError
    )

  player_leave_success: (player) ->
    $("#player-tr-#{player.get('id')}").remove()
    view = new Realballerz.Views.BenchPlayer(model: player)
    team_id = player.get('team_id')
    $("#bench_players_in_team_#{team_id}").append(view.render().el)
    alert("#{player.get('name')} leaves game")

  player_entry_success: (player) ->
    $("#player-tr-#{player.get('id')}").remove()
    view = new Realballerz.Views.PlayerAction(model: player)
    team_id = player.get('team_id')
    $("#game_players_in_team_#{team_id}").append(view.render().el)
    alert("#{player.get('name')} enters game")

  update_player_stat: (player) ->
    console.log(player.get('name'))

  render: =>
    if @game = @collection.get(@id)
      @set_players(this)
      $(@el).html(@template(home_team_id: @game.get('home_team_id'), away_team_id: @game.get('away_team_id')))
    this

  handleError: (entry, response) ->
    if response.status != 200
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

