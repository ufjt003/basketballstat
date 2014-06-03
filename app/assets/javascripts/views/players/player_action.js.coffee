class Realballerz.Views.PlayerAction extends Backbone.View
  template: JST['players/player_action']
  tagName: 'tr'

  render: ->
    $(@el).attr('id', "player-tr-#{@model.id}").html(@template(player: @model))
    this
