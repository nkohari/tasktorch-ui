_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'
TeamsLoadedEvent  = require 'events/TeamsLoadedEvent'

class LoadMyTeamsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/me/teams?expand=stacks", (res) =>
      stacks = _.flatten _.map res.body, (team) -> team['_related'].stacks
      teams = _.map res.body, (team) -> _.omit(team, '_related')
      eventBus.publish new StacksLoadedEvent(stacks)
      eventBus.publish new TeamsLoadedEvent(teams)

module.exports = LoadMyTeamsRequest
