superagent       = require 'superagent'
Goal             = require 'data/models/Goal'
GoalCreatedEvent = require 'events/create/GoalCreatedEvent'
Request          = require 'data/framework/Request'

class CreateGoalRequest extends Request

  constructor: (@name) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/goals")
    .send({@name})
    .end (res) =>
      goal = new Goal(res.body.goal)
      eventQueue.publish new GoalCreatedEvent(goal)

module.exports = CreateGoalRequest
