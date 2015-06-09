_                     = require 'lodash'
superagent            = require 'superagent'
Request               = require 'data/framework/Request'
Goal                  = require 'data/models/Goal'
GoalsLoadedEvent      = require 'events/load/GoalsLoadedEvent'
GoalsByOrgLoadedEvent = require 'events/load/GoalsByOrgLoadedEvent'

class LoadGoalsByOrgRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{@orgid}/goals", (res) =>
      goals = _.map res.body.goals, (data) -> new Goal(data)
      eventQueue.publish new GoalsLoadedEvent(goals)
      eventQueue.publish new GoalsByOrgLoadedEvent(@orgid, goals)

module.exports = LoadGoalsByOrgRequest
