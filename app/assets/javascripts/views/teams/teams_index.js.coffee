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
    attributes = { team: { name: $('#new_team_name').val() } }
    @collection.create(
      attributes,
      wait: true
      success: -> $('#new_team')[0].reset()
      error: @handleError
    )

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  appendTeam: (team) ->
    view = new Realballerz.Views.Team(model: team)
    $('#teams').append(view.render().el)

