class Realballerz.Views.PlayerGameStats extends Backbone.View
  template: JST['games/player_stats']

  initialize: (options) ->
    @set_home_player_stats(this)
    @set_away_player_stats(this)

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

  render: =>
    $(@el).html(@template())
    this
