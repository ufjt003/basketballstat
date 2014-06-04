class Realballerz.Views.PlayersWithNoTeam extends Backbone.View

  template: JST['teams/players_with_no_team']

  initialize: ->
    @collection = new Realballerz.Collections.Players()
    @collection.fetch({reset: true, data: $.param({ not_in_a_team: true})})
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(players_with_no_team: @collection))
    $("#add_new_player_form").hide() if @collection.length == 0
    this
