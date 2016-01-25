Goal             = require 'data/models/Goal'
GoalChangedEvent = require 'events/change/GoalChangedEvent'
Request          = require 'data/framework/Request'

class ChangeGoalDescriptionRequest extends Request

  constructor: (@goalid, @description) ->

  create: (identity, agent) ->
    agent.post(@urlFor("/#{identity.orgid}/goals/#{@goalid}/description"))
    .withCredentials()
    .send {@description}

  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalChangedEvent(goal)

module.exports = ChangeGoalDescriptionRequest
