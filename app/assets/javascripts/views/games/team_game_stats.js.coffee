class Realballerz.Views.TeamGameStats extends Backbone.View
  template: JST['games/team_stats']

  initialize: (options) ->
    @set_team_stats(this)
    @collection.on('reset', @render)

  set_team_stats: ->
    @team_stats = new Realballerz.Collections.Stats()
    @team_stats.url = "/api/games/#{@id}/team_stats"
    @team_stats.on('reset', @fill_team_stats, this)
    @team_stats.fetch({reset: true})

  fill_team_stats: (stats) ->
    stats.each(@append_team_stat)

  append_team_stat: (stat) ->
    tag_id = "tr-game-stat-team-#{stat.get('team_id')}"
    view = new Realballerz.Views.Stat(model: stat, id: tag_id)
    $("##{tag_id}").replaceWith(view.render().el)

  render: =>
    if @game = @collection.get(@id)
      $(@el).html(@template(home_team_id: @game.get('home_team_id'), away_team_id: @game.get('away_team_id')))
    this
