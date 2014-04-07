class Realballerz.Views.PlayersIndex extends Backbone.View

  template: JST['players/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendPlayer)
    this

  appendPlayer: (player) ->
    view = new Realballerz.Views.Player(model: player)
    $('#players').append(view.render().el)

