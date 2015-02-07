_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
GoalsLoadedEvent = require 'events/load/GoalsLoadedEvent'

class LoadAllGoalsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/goals", (res) =>
      {goals} = res.body
      eventBus.publish new GoalsLoadedEvent(goals)

module.exports = LoadAllGoalsRequest
