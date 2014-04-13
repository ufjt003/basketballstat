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
    @collection.create(
      { player: { name: $('#new_player_name').val(), number: $('#new_player_number').val() } },
      { wait: true }
    )
    $('#new_player')[0].reset()

  appendPlayer: (player) ->
    view = new Realballerz.Views.Player(model: player)
    $('#players').append(view.render().el)

