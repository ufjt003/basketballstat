class Realballerz.Routers.Teams extends Backbone.Router
  routes:
    'teams': 'index'
    'teams/:id': 'show'

  initialize: ->
    @collection = new Realballerz.Collections.Teams()
    @collection.fetch({reset: true})
    @players_with_no_team = new Realballerz.Collections.Players()
    @players_with_no_team.fetch({reset: true, data: $.param({ not_in_a_team: true})})

  index: ->
    view = new Realballerz.Views.TeamsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    view = new Realballerz.Views.TeamsShow(collection: @collection, id: id, players_with_no_team: @players_with_no_team)
    $('#container').html(view.render().el)
