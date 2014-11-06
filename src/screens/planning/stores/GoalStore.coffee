_     = require 'lodash'
Store = require 'framework/Store'

class GoalStore extends Store

  constructor: ->
    @goals = {}

  getAllGoals: ->
    _.values(@goals)

  onGoalsLoaded: (event) ->
    @goals = _.extend @goals, _.indexBy(event.goals, 'id')
    @announce()

module.exports = GoalStore
