_                      = require 'lodash'
Request                = require 'data/framework/Request'
Goal                   = require 'data/models/Goal'
GoalsLoadedEvent       = require 'events/load/GoalsLoadedEvent'
GoalsByCardLoadedEvent = require 'events/load/GoalsByCardLoadedEvent'

class LoadGoalsByCardRequest extends Request

  constructor: (@cardid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/cards/#{@cardid}/goals"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    goals = _.map result.goals, (data) -> new Goal(data)
    publish new GoalsLoadedEvent(goals)
    publish new GoalsByCardLoadedEvent(@cardid, goals)

module.exports = LoadGoalsByCardRequest
