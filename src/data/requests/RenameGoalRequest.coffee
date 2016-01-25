Goal             = require 'data/models/Goal'
Request          = require 'data/framework/Request'
GoalChangedEvent = require 'events/change/GoalChangedEvent'

class RenameGoalRequest extends Request

  constructor: (@goalid, @name) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/goals/#{@goalid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalChangedEvent(goal)

module.exports = RenameGoalRequest
