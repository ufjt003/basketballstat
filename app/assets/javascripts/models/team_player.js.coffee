class Realballerz.Models.TeamPlayer extends Backbone.Model
  initialize: (options) ->
    @url = "/api/teams/#{options.team_id}/add_player/#{options.player_id}"

