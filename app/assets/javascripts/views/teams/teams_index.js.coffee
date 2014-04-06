class Realballerz.Views.TeamsIndex extends Backbone.View

  template: JST['teams/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(teams: @collection))
    this
