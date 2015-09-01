Goal             = require 'data/models/Goal'
GoalsLoadedEvent = require 'events/load/GoalsLoadedEvent'
Request          = require 'data/framework/Request'

class LoadGoalRequest extends Request

  constructor: (@goalid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/goals/#{@goalid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    goal = new Goal(result.goal)
    publish new GoalsLoadedEvent([goal])

module.exports = LoadGoalRequest
