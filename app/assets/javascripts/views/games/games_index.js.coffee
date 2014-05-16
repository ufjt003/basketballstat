class Realballerz.Views.GamesIndex extends Backbone.View

  template: JST['games/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendGame)
    this

  appendGame: (game) ->
    view = new Realballerz.Views.Game(model: game)
    $('#games > tbody:last').append(view.render().el)

