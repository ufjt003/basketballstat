class Realballerz.Views.GamesShow extends Backbone.View
  template: JST['games/show']

  initialize: (options) ->
    @collection.on('reset', @render)
    @home_team_stat = new Realballerz.Models.Stat()
    @home_team_stat.url = "/api/games/#{@id}/home_team_stat"
    @home_team_stat.on('change', @fill_home_team_stat, this)
    @home_team_stat.fetch()
    @away_team_stat = new Realballerz.Models.Stat()
    @away_team_stat.url = "/api/games/#{@id}/away_team_stat"
    @away_team_stat.on('change', @fill_away_team_stat, this)
    @away_team_stat.fetch()

  fill_home_team_stat: (stat) =>
    view = new Realballerz.Views.Stat(model: stat, id: 'tr-home-team-stat')
    $('#tr-home-team-stat').replaceWith(view.render().el)

  fill_away_team_stat: (stat) =>
    view = new Realballerz.Views.Stat(model: stat, id: 'tr-away-team-stat')
    $('#tr-away-team-stat').replaceWith(view.render().el)

  render: =>
    @game = @collection.get(@id)
    if @game != undefined
      $(@el).html(@template(game: @game))
    this
