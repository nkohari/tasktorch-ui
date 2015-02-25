Goal            = require 'data/models/Goal'
ModelStore      = require 'data/framework/ModelStore'
LoadGoalRequest = require 'data/requests/LoadGoalRequest'

class GoalStore extends ModelStore

  displayName: 'GoalStore'
  name:        'goals'
  modelType:   Goal

  listensFor: [
    'GoalsLoaded'
  ]

  load: (id) ->
    @execute new LoadGoalRequest(id)

  onGoalsLoaded: (event) ->
    @add(event.goals)

module.exports = GoalStore
