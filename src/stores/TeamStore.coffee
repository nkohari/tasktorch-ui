_     = require 'lodash'
Store = require 'framework/Store'

class TeamStore extends Store

  getAllByMember: (userId) ->
    _.filter @items, (team) -> _.contains(team.members, userId)

  onTeamsLoaded: (event) ->
    @add(event.teams)

module.exports = TeamStore
