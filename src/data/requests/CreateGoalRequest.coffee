Goal             = require 'data/models/Goal'
GoalCreatedEvent = require 'events/create/GoalCreatedEvent'
Request          = require 'data/framework/Request'

class CreateGoalRequest extends Request

  constructor: (@orgid, @name) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/goals"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalCreatedEvent(goal)

module.exports = CreateGoalRequest
