_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
GoalsLoadedEvent = require 'events/GoalsLoadedEvent'

class LoadAllGoalsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/goals", (res) =>
      eventBus.publish new GoalsLoadedEvent(res.body)

module.exports = LoadAllGoalsRequest
