window.Realballerz =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Realballerz.Routers.Players
    Backbone.history.start()

$(document).ready ->
  Realballerz.initialize()
