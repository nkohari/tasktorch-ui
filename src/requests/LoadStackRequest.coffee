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
      {stack} = res.body
      users = _.values(res.body.related.users)
      teams = _.values(res.body.related.teams)
      eventBus.publish new UsersLoadedEvent(users) if users?.length > 0
      eventBus.publish new TeamsLoadedEvent(teams) if teams?.length > 0
      eventBus.publish new StacksLoadedEvent([stack])

module.exports = LoadStackRequest
