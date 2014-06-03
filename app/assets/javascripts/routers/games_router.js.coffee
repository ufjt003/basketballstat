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
    @teams = new Realballerz.Collections.Teams()
    @teams.fetch({reset: true})

  index: ->
    view = new Realballerz.Views.GamesIndex(collection: @collection, teams: @teams)
    $('#container').html(view.render().el)

  show: (id) ->
    view = new Realballerz.Views.GamesShow(collection: @collection, id: id)
    $('#container').html(view.render().el)

  team_stats: (id) ->
    view = new Realballerz.Views.TeamGameStats(id: id)
    $('#container').html(view.render().el)

  player_stats: (id) ->
    view = new Realballerz.Views.PlayerGameStats(id: id)
    $('#container').html(view.render().el)

  players: (id) ->
    view = new Realballerz.Views.GamePlayers(id: id)
    $('#container').html(view.render().el)

