class Realballerz.Views.TeamsShow extends Backbone.View

  template: JST['teams/show']

  events:
    'click #teams_index': 'teams_index'

  initialize: ->
    @collection.on('reset', @render)

  render: =>
    team = @collection.get(@id)
    if team != undefined
      $(@el).html(@template(team: team))
    this

  teams_index: ->
    Backbone.history.navigate("teams", true)

