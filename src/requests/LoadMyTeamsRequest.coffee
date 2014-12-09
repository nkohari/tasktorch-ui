_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'
TeamsLoadedEvent  = require 'events/TeamsLoadedEvent'

class LoadMyTeamsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/me/teams?expand=stacks", (res) =>
      {teams} = res.body
      stacks = _.values(res.body.related.stacks)
      eventBus.publish new StacksLoadedEvent(stacks)
      eventBus.publish new TeamsLoadedEvent(teams)

module.exports = LoadMyTeamsRequest
