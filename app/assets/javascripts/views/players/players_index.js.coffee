class Realballerz.Views.PlayersIndex extends Backbone.View

  template: JST['players/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(players: @collection))
    this
