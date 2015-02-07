_ = require 'lodash'

class PlanningUrl

  constructor: (routes, params, query) ->
    @orgid = params.orgid
    @goal = query.goal

  setGoal: (goal) ->
    @goal = goal

  makeLinkProps: ->
    params = {@orgid}
    query  = {}
    query.goal = @goal if @goal?
    return {to: 'planning', params, query}

module.exports = PlanningUrl
