class Realballerz.Views.Game extends Backbone.View
  template: JST['games/game']
  tagName: 'tr'

  render: ->
    $(@el).html(@template(game: @model))
    this

