class Realballerz.Views.TeamsIndex extends Backbone.View

  template: JST['teams/index']

  events:
    'submit #new_team': 'createTeam'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendTeam, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendTeam)
    this

  createTeam: (event) ->
    event.preventDefault()
    @collection.create(
      { team: { name: $('#new_team_name').val() } },
      { wait: true }
    )
    $('#new_team')[0].reset()

  appendTeam: (team) ->
    view = new Realballerz.Views.Team(model: team)
    $('#teams').append(view.render().el)

