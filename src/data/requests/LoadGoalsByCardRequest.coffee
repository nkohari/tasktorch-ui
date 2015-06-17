_                      = require 'lodash'
superagent             = require 'superagent'
Request                = require 'data/framework/Request'
Goal                   = require 'data/models/Goal'
GoalsLoadedEvent       = require 'events/load/GoalsLoadedEvent'
GoalsByCardLoadedEvent = require 'events/load/GoalsByCardLoadedEvent'

class LoadGoalsByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/goals"))
    .withCredentials()
    .end (err, res) =>
      goals = _.map res.body.goals, (data) -> new Goal(data)
      eventQueue.publish new GoalsLoadedEvent(goals)
      eventQueue.publish new GoalsByCardLoadedEvent(@cardid, goals)

module.exports = LoadGoalsByCardRequest
