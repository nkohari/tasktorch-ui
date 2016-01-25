Goal             = require 'data/models/Goal'
GoalChangedEvent = require 'events/change/GoalChangedEvent'
Request          = require 'data/framework/Request'

class ChangeGoalTimeframeRequest extends Request

  constructor: (@goalid, @timeframe) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/goals/#{@goalid}/timeframe"))
    .withCredentials()
    .send {@timeframe}
     
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalChangedEvent(goal)

module.exports = ChangeGoalTimeframeRequest
