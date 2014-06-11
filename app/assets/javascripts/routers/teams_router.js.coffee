class Realballerz.Routers.Teams extends Backbone.Router
  routes:
    'teams': 'index'
    'teams/:id': 'show'

  initialize: ->
    @collection = new Realballerz.Collections.Teams()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.TeamsIndex(collection: @collection)
    $('#backbone_container').html(view.render().el)

  show: (id) ->
    view = new Realballerz.Views.TeamsShow(collection: @collection, id: id)
    $('#backbone_container').html(view.render().el)
