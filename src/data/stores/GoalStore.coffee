Goal              = require 'data/models/Goal'
ModelStore        = require 'data/framework/ModelStore'
LoadGoalRequest   = require 'data/requests/LoadGoalRequest'
CreateGoalRequest = require 'data/requests/CreateGoalRequest'

class GoalStore extends ModelStore

  displayName: 'GoalStore'
  name:        'goals'
  modelType:   Goal

  listensFor: [
    'GoalsLoaded'
    'GoalChanged'
    'UserCreatedGoal'
  ]

  load: (id) ->
    @execute new LoadGoalRequest(id)

  onGoalsLoaded: (event) ->
    @add(event.goals)

  onGoalChanged: (event) ->
    @set(event.goal.id, event.goal)

  onUserCreatedGoal: (event) ->
    @execute new CreateGoalRequest(event.orgid, event.name)

module.exports = GoalStore
