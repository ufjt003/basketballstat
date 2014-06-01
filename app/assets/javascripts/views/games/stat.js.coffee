class Realballerz.Views.Stat extends Backbone.View
  template: JST['games/stat']
  tagName: 'tr'

  render: ->
    $(@el).attr('id', @id).html(@template(stat: @model))
    this

