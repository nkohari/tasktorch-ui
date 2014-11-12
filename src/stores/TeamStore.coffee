_     = require 'lodash'
Store = require 'framework/Store'

class TeamStore extends Store

  constructor: ->
    @teams = {}

  getTeam: (id) ->
    @teams[id]

  getAllTeams: ->
    _.values(@teams)

  onTeamsLoaded: (event) ->
    @teams = _.indexBy(event.teams, 'id')
    @announce()

module.exports = TeamStore
