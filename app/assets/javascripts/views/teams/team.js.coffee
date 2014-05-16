class Realballerz.Views.Team extends Backbone.View
  template: JST['teams/team']
  tagName: 'tr'

  render: ->
    $(@el).html(@template(team: @model))
    this

