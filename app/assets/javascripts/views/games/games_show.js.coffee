class Realballerz.Views.GamesShow extends Backbone.View
  template: JST['games/show']

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

