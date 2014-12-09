_     = require 'lodash'
Store = require 'framework/Store'

class TeamStore extends Store

  constructor: ->
    @teams = {}

  getTeam: (id) ->
    @teams[id]

  getAllTeams: ->
    _.values(@teams)

  getTeamsByMember: (userId) ->
    _.filter @teams, (team) -> _.contains(team.members, userId)

  onTeamsLoaded: (event) ->
    @teams = _.indexBy(event.teams, 'id')
    @announce()

module.exports = TeamStore
