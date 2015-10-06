_                     = require 'lodash'
Request               = require 'data/framework/Request'
Goal                  = require 'data/models/Goal'
GoalsLoadedEvent      = require 'events/load/GoalsLoadedEvent'
GoalsByOrgLoadedEvent = require 'events/load/GoalsByOrgLoadedEvent'

class LoadGoalsByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{@orgid}/goals"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    goals = _.map result.goals, (data) -> new Goal(data)
    publish new GoalsLoadedEvent(goals)
    publish new GoalsByOrgLoadedEvent(@orgid, goals)

module.exports = LoadGoalsByOrgRequest
