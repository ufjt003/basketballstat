class Realballerz.Views.TeamsIndex extends Backbone.View

  template: JST['teams/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendTeam)
    this

  appendTeam: (team) ->
    view = new Realballerz.Views.Team(model: team)
    $('#teams').append(view.render().el)

