class Realballerz.Views.TeamGameStats extends Backbone.View
  template: JST['games/team_stats']

  initialize: (options) ->
    @set_home_team_stat(this)
    @set_away_team_stat(this)

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

  fill_home_team_stat: (stat) ->
    @fill_team_stat(stat, "tr-home-team-stat")

  fill_away_team_stat: (stat) ->
    @fill_team_stat(stat, "tr-away-team-stat")

  fill_team_stat: (stat, id) ->
    view = new Realballerz.Views.Stat(model: stat, id: id)
    $("##{id}").replaceWith(view.render().el)

  render: =>
    $(@el).html(@template())
    this
