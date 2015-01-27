_ = require 'lodash'

class PlanningUrl

  constructor: (routes, params, query) ->
    @orgId = params.orgId
    @goal = query.goal

  setGoal: (goal) ->
    @goal = goal

  makeLinkProps: ->
    params = {@orgId}
    query  = {}
    query.goal = @goal if @goal?
    return {to: 'planning', params, query}

module.exports = PlanningUrl
