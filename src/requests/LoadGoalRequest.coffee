_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
GoalsLoadedEvent = require 'events/load/GoalsLoadedEvent'

class LoadGoalRequest extends Request

  constructor: (@goalId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/goals/#{@goalId}", (res) =>
      {goal} = res.body
      eventBus.publish new GoalsLoadedEvent([goal])

module.exports = LoadGoalRequest
