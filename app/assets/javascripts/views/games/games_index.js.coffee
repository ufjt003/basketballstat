class Realballerz.Views.GamesIndex extends Backbone.View

  template: JST['games/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(games: @collection))
    this
