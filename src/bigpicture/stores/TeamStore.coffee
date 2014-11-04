_     = require 'lodash'
Store = require '../../framework/Store'

class TeamStore extends Store

  constructor: ->
    @teams = {}

  getAllTeams: ->
    _.values(@teams)

  onTeamsLoaded: (event) ->
    @teams = _.extend @teams, _.indexBy(event.teams, 'id')
    @announce()

module.exports = TeamStore
