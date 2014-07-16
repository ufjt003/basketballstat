class Realballerz.Views.BenchPlayer extends Backbone.View
  tagName: 'tr'

  render: ->
    $(@el).attr('id', "player-tr-#{@model.id}").html("<td>#{@model.get('name')}</td><td><a class='player_enter' data='#{@model.get('id')}'>Enter Game</a></td>")
    this

