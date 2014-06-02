class Realballerz.Views.GamesShow extends Backbone.View
  template: JST['games/show']

  events:
    'click #start_game': 'start_game'
    'click #finish_game': 'finish_game'
    'click #restart_game': 'restart_game'

  start_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/start"
      @game.save(
        {},
        wait: true
        success: @game_started
        error: @handleError
      )

  finish_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/finish"
      @game.save(
        {},
        wait: true
        success: @game_finished
        error: @handleError
      )

  restart_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/restart"
      @game.save(
        {},
        wait: true
        success: @game_started
        error: @handleError
      )

  game_started: (entry) ->
    alert('game_started')
    $("#game_status").replaceWith("<h4 id='game_status'><a id='finish_game'>Finish Game</a></h4>")

  game_finished: (entry) ->
    alert('game_finished')
    $("#game_status").replaceWith("<h4 id='game_status'>Finished (<a id='restart_game'>Restart</a>)</h4>")

  initialize: (options) ->
    @collection.on('reset', @render)
    @set_home_team_stat(this)
    @set_away_team_stat(this)
    @set_home_player_stats(this)
    @set_away_player_stats(this)

  render: =>
    @game = @collection.get(@id)
    if @game != undefined
      $(@el).html(@template(game: @game))
    this

  set_home_team_stat: ->
    @home_team_stat = new Realballerz.Models.Stat()
    @home_team_stat.url = "/api/games/#{@id}/home_team_stat"
    @home_team_stat.on('change', @fill_home_team_stat, this)
    @home_team_stat.fetch()

  set_away_team_stat: ->
    @away_team_stat = new Realballerz.Models.Stat()
    @away_team_stat.url = "/api/games/#{@id}/away_team_stat"
    @away_team_stat.on('change', @fill_away_team_stat, this)
    @away_team_stat.fetch()

  set_home_player_stats: ->
    @home_player_stats = new Realballerz.Collections.Stats()
    @home_player_stats.url = "/api/games/#{@id}/home_player_stats"
    @home_player_stats.on('reset', @update_home_player_stats, this)
    @home_player_stats.fetch({reset: true})

  set_away_player_stats: ->
    @away_player_stats = new Realballerz.Collections.Stats()
    @away_player_stats.url = "/api/games/#{@id}/away_player_stats"
    @away_player_stats.on('reset', @update_away_player_stats, this)
    @away_player_stats.fetch({reset: true})

  update_home_player_stats: (stats) ->
    stats.each(@append_home_player_stat)

  update_away_player_stats: (stats) ->
    stats.each(@append_away_player_stat)

  append_home_player_stat: (stat) ->
    view = new Realballerz.Views.Stat(model: stat, id: "player-stat-#{stat.get('player_id')}")
    $('#home-player-stats > tbody:last').append(view.render().el)

  append_away_player_stat: (stat) ->
    view = new Realballerz.Views.Stat(model: stat, id: "player-stat-#{stat.get('player_id')}")
    $('#away-player-stats > tbody:last').append(view.render().el)

  fill_home_team_stat: (stat) ->
    @fill_team_stat(stat, "tr-home-team-stat")

  fill_away_team_stat: (stat) ->
    @fill_team_stat(stat, "tr-away-team-stat")

  fill_team_stat: (stat, id) ->
    view = new Realballerz.Views.Stat(model: stat, id: id)
    $("##{id}").replaceWith(view.render().el)

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

