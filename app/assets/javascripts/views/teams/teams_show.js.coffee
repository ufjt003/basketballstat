class Realballerz.Views.TeamsShow extends Backbone.View

  template: JST['teams/show']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    team = @collection.get(@id)
    if team != undefined
      $(@el).html(@template(team: team))
    this

  appendTeam: (team) ->
    view = new Realballerz.Views.Team(model: team)
    $('#teams > tbody:last').append(view.render().el)

