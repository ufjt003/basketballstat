class Realballerz.Views.Player extends Backbone.View
  template: JST['players/player']
  tagName: 'li'

  render: ->
    $(@el).html(@template(player: @model))
    this

