class Realballerz.Views.PlayerGameStats extends Backbone.View
  template: JST['games/player_stats']

  initialize: (options) ->
    #@set_home_player_stats(this)
    #@set_away_player_stats(this)
    @set_player_stats(this)
    @collection.on('reset', @render)

  set_player_stats: ->
    @player_stats = new Realballerz.Collections.Stats()
    @player_stats.url = "/api/games/#{@id}/player_stats"
    @player_stats.on('reset', @update_player_stats, this)
    @player_stats.fetch({reset: true})

  update_player_stats: (stats) ->
    stats.each(@append_player_stat)

  append_player_stat: (stat) ->
    tag_id = "player-stat-#{stat.get('player_id')}"
    view = new Realballerz.Views.Stat(model: stat, id: tag_id)
    $("#player-stats-team-#{stat.get('team_id')} > tbody:last").append(view.render().el)

  render: =>
    if @game = @collection.get(@id)
      $(@el).html(@template(home_team_id: @game.get('home_team_id'), away_team_id: @game.get('away_team_id')))
    this
