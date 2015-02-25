superagent       = require 'superagent'
Goal             = require 'data/models/Goal'
GoalsLoadedEvent = require 'events/load/GoalsLoadedEvent'
Request          = require 'data/framework/Request'

class LoadGoalRequest extends Request

  constructor: (@goalid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/goals/#{@goalid}", (res) =>
      goal = new Goal(res.body.goal)
      eventQueue.publish new GoalsLoadedEvent([goal])

module.exports = LoadGoalRequest
