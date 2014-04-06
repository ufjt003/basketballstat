class Realballerz.Routers.Players extends Backbone.Router
  routes:
    '': 'index'
    'players': 'index'
    'players/:id': 'show'

  initialize: ->
    @collection = new Realballerz.Collections.Players()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.PlayersIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Player #{id}"
