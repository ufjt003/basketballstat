class Realballerz.Views.TeamsIndex extends Backbone.View

  template: JST['teams/index']

  events:
    'submit #new_team_form': 'createTeam'
    'click #edit_team': 'editTeam'

  initialize: ->
    @collection.on('reset', @render)
    @collection.on('add', @appendTeam)

  render: =>
    $(@el).html(@template())
    @collection.each(@appendTeam)
    this

  createTeam: (event) ->
    event.preventDefault()
    attributes = { team: { name: $('#new_team_name').val() } }
    @collection.create(
      attributes,
      wait: true
      success: -> $('#new_team_form')[0].reset()
      error: @handleError
    )

  editTeam: (event) ->
    id = event.target.getAttribute('data')
    Backbone.history.navigate("teams/#{id}", true)

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  appendTeam: (team) =>
    view = new Realballerz.Views.Team(model: team)
    @$('#teams > tbody:last').append(view.render().el)

