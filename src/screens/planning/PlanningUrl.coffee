_ = require 'lodash'

class PlanningUrl

  constructor: (routes, params, query) ->
    @organizationId = params.organizationId
    @goal = query.goal

  setGoal: (goal) ->
    @goal = goal

  makeLinkProps: ->
    params = {@organizationId}
    query  = {}
    query.goal = @goal if @goal?
    return {to: 'planning', params, query}

module.exports = PlanningUrl
