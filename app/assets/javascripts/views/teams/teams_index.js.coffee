class Realballerz.Views.TeamsIndex extends Backbone.View

  template: JST['teams/index']

  events:
    'submit #new_team_form': 'createTeam'
    'click #edit_team': 'editTeam'
    'click #remove_team': 'removeTeam'

  initialize: ->
    @collection.on('reset', @render)
    @collection.on('add', @appendTeam)
    @collection.on('destroy', @clearTeam, this)

  clearTeam: (team) ->
    $("#team-tr-#{team.get('id')}").remove()
    alert("removed team #{team.get('name')}")

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
    event.preventDefault()
    id = event.target.getAttribute('data')
    Backbone.history.navigate("teams/#{id}", true)

  removeTeam: (event) ->
    event.preventDefault()
    game_id = event.target.getAttribute('data')
    team = @collection.get(game_id)
    team.destroy(
      wait: true
      error: @handleError
    )

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  appendTeam: (team) =>
    view = new Realballerz.Views.Team(model: team)
    @$('#teams > tbody:last').append(view.render().el)

