class Realballerz.Views.PlayersIndex extends Backbone.View

  template: JST['players/index']

  events:
    'submit #new_player': 'createPlayer'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendPlayer, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendPlayer)
    this

  createPlayer: (event) ->
    event.preventDefault()
    attributes = { player: { name: $('#new_player_name').val(), number: $('#new_player_number').val() } }
    @collection.create(
      attributes,
      wait: true
      success: -> $('#new_player')[0].reset()
      error: @handleError
    )

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  appendPlayer: (player) ->
    view = new Realballerz.Views.Player(model: player)
    $('#players > tbody:last').append(view.render().el)
