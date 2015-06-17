superagent       = require 'superagent'
Goal             = require 'data/models/Goal'
GoalCreatedEvent = require 'events/create/GoalCreatedEvent'
Request          = require 'data/framework/Request'

class CreateGoalRequest extends Request

  constructor: (@name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/goals"))
    .withCredentials()
    .send({@name})
    .end (err, res) =>
      goal = new Goal(res.body.goal)
      eventQueue.publish new GoalCreatedEvent(goal)

module.exports = CreateGoalRequest
