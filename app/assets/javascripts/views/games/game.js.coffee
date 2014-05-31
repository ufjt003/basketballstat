class Realballerz.Views.Game extends Backbone.View
  template: JST['games/game']
  tagName: 'tr'

  render: ->
    $(@el).attr('id', "game-tr-#{@model.id}").html(@template(game: @model))
    this

