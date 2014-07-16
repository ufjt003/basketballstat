class Realballerz.Routers.Games extends Backbone.Router
  routes:
    'games': 'index'
    'games/:id': 'show'
    'games/:id/team_stats': 'team_stats'
    'games/:id/player_stats': 'player_stats'
    'games/:id/players': 'players'

  initialize: ->
    @collection = new Realballerz.Collections.Games()
    @collection.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.GamesIndex(collection: @collection)
    $('#backbone_container').html(view.render().el)

  show: (id) ->
    view = new Realballerz.Views.GamesShow(collection: @collection, id: id)
    $('#backbone_container').html(view.render().el)

  team_stats: (id) ->
    view = new Realballerz.Views.TeamGameStats(collection: @collection, id: id)
    $('#backbone_container').html(view.render().el)

  player_stats: (id) ->
    view = new Realballerz.Views.PlayerGameStats(collection: @collection, id: id)
    $('#backbone_container').html(view.render().el)

  players: (id) ->
    view = new Realballerz.Views.GamePlayers(collection: @collection, id: id)
    $('#backbone_container').html(view.render().el)

