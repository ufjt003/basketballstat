class Realballerz.Views.GamesShow extends Backbone.View
  template: JST['games/show']

  events:
    'click #start_game': 'start_game'
    'click #finish_game': 'finish_game'
    'click #restart_game': 'restart_game'

  initialize: (options) ->
    @collection.on('reset', @render)

  render: =>
    @game = @collection.get(@id)
    if @game != undefined
      $(@el).html(@template(game: @game))
      view = new Realballerz.Views.TeamGameStats(id: @id)
      $('#team-stats').replaceWith(view.render().el)
      view = new Realballerz.Views.PlayerGameStats(id: @id)
      $('#player-stats').replaceWith(view.render().el)
      view = new Realballerz.Views.GamePlayers(id: @id)
      $('#game-players').replaceWith(view.render().el)
    this

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      alert(errors)

  start_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/start"
      @game.save(
        {},
        wait: true
        success: @game_started
        error: @handleError
      )

  finish_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/finish"
      @game.save(
        {},
        wait: true
        success: @game_finished
        error: @handleError
      )

  restart_game: (event) ->
    event.preventDefault()
    if @game != undefined
      @game.url = "/api/games/#{@id}/restart"
      @game.save(
        {},
        wait: true
        success: @game_started
        error: @handleError
      )

  game_started: (game) ->
    alert('game_started')
    $("#game_status").replaceWith("<h4 id='game_status'><a id='finish_game'>Finish Game</a></h4>")

  game_finished: (game) ->
    alert('game_finished')
    $("#game_status").replaceWith("<h4 id='game_status'>Finished (<a id='restart_game'>Restart</a>)</h4>")


