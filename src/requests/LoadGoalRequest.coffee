_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
GoalsLoadedEvent = require 'events/GoalsLoadedEvent'

class LoadGoalRequest extends Request

  constructor: (@goalId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/goals/#{@goalId}", (res) =>
      eventBus.publish new GoalsLoadedEvent([res.body])

module.exports = LoadGoalRequest
