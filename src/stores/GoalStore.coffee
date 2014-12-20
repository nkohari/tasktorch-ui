_     = require 'lodash'
Store = require 'framework/Store'

class GoalStore extends Store

  onGoalsLoaded: (event) ->
    @add(event.goals)

module.exports = GoalStore
