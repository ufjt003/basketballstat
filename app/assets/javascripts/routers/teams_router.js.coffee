class Realballerz.Routers.Teams extends Backbone.Router
  routes:
    'teams': 'index'
    'teams/:id': 'show'

  initialize: ->
    @collection = new Realballerz.Collections.Teams()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.TeamsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Team #{id}"
