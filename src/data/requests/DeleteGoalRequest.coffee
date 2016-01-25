Goal             = require 'data/models/Goal'
GoalDeletedEvent = require 'events/delete/GoalDeletedEvent'
Request          = require 'data/framework/Request'

class DeleteGoalRequest extends Request

  constructor: (@goalid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/goals/#{@goalid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalDeletedEvent(goal)

module.exports = DeleteGoalRequest
