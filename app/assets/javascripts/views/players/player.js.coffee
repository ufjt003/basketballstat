class Realballerz.Views.Player extends Backbone.View
  template: JST['players/player']
  tagName: 'tr'

  render: ->
    $(@el).attr('id', "player-tr-#{@model.id}").html(@template(player: @model, show_remove_link: @show_remove_link))
    this
