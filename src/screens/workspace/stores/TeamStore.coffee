_     = require 'lodash'
Store = require 'framework/Store'

class TeamStore extends Store

  constructor: ->
    @teams = {}

  onWorkspaceLoaded: (event) ->
    @teams = _.indexBy(event.workspace.teams, 'id')
    @announce()

module.exports = TeamStore
