Goal             = require 'data/models/Goal'
GoalChangedEvent = require 'events/change/GoalChangedEvent'
Request          = require 'data/framework/Request'

class ChangeGoalStatusRequest extends Request

  constructor: (@goalid, @status) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/goals/#{@goalid}/status"))
    .withCredentials()
    .send {@status}
     
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalChangedEvent(goal)

module.exports = ChangeGoalStatusRequest
