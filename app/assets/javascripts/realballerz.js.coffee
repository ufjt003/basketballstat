window.Realballerz =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Realballerz.Routers.Players
    new Realballerz.Routers.Games
    new Realballerz.Routers.Teams
    Backbone.history.start()

$(document).ready ->
  Realballerz.initialize()
