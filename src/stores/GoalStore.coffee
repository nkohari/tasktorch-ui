_               = require 'lodash'
Store           = require 'framework/Store'
LoadGoalRequest = require 'requests/LoadGoalRequest'

class GoalStore extends Store

  displayName: 'GoalStore'

  onGoalDisplayed: (event) ->
    if @get(event.goalId)?
      @announce()
    else
      @execute new LoadGoalRequest(event.goalId)

  onGoalsLoaded: (event) ->
    @add(event.goals)

module.exports = GoalStore
