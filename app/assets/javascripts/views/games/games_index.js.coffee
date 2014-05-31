class Realballerz.Views.GamesIndex extends Backbone.View

  template: JST['games/index']

  events:
    'submit #create_new_game_form': 'createNewGame'

  createNewGame: (event) ->
    event.preventDefault()
    attributes = { game: { some_data: "something" }, home_team_id: $('#home_team_id').val(), away_team_id: $('#away_team_id').val() }
    console.log(attributes)
    @collection.create(
      attributes,
      wait: true
      error: @handleError
    )

  handleError: (entry, response) ->
    if response.status != 200
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  initialize: (options) ->
    @teams = options.teams
    @collection.on('reset', @render, this)
    @teams.on('reset', @render, this)
    @collection.on('add', @appendGame, this)

  render: ->
    $(@el).html(@template(teams: @teams))
    @collection.each(@appendGame)
    this

  appendGame: (game) ->
    view = new Realballerz.Views.Game(model: game)
    $('#games > tbody:last').append(view.render().el)

