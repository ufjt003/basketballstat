class Realballerz.Routers.Games extends Backbone.Router
  routes:
    'games': 'index'
    'games/:id': 'show'

  initialize: ->
    @collection = new Realballerz.Collections.Games()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.GamesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Game #{id}"
