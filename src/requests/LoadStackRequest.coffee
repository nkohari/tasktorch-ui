_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
UsersLoadedEvent  = require 'events/UsersLoadedEvent'
TeamsLoadedEvent  = require 'events/TeamsLoadedEvent'
StacksLoadedEvent = require 'events/StacksLoadedEvent'

class LoadStackRequest extends Request

  constructor: (@stackId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/stacks/#{@stackId}?expand=owner,team", (res) =>
      {owner, team} = res.body['_related']
      stack = _.omit(res.body, '_related')
      eventBus.publish new UsersLoadedEvent([owner]) if owner?
      eventBus.publish new TeamsLoadedEvent([team]) if team?
      eventBus.publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
