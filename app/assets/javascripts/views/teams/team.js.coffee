class Realballerz.Views.Team extends Backbone.View
  template: JST['teams/team']
  tagName: 'tr'

  render: ->
    $(@el).attr('id', "team-tr-#{@model.id}").html(@template(team: @model))
    this

