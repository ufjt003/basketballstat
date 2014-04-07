class Realballerz.Views.Game extends Backbone.View
  template: JST['games/game']
  tagName: 'li'

  render: ->
    $(@el).html(@template(game: @model))
    this

