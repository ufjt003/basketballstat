class Realballerz.Routers.Players extends Backbone.Router
  routes:
    '': 'index'
    'players': 'index'
    'players/:id': 'show'
    'players_with_no_team': 'players_with_no_team'

  initialize: ->
    @collection = new Realballerz.Collections.Players()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.PlayersIndex(collection: @collection)
    $('#container').html(view.render().el)

  players_with_no_team: ->
    view = new Realballerz.Views.PlayersWithNoTeam()
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Player #{id}"
