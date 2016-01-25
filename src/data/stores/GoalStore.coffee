Goal                         = require 'data/models/Goal'
ModelStore                   = require 'data/framework/ModelStore'
LoadGoalRequest              = require 'data/requests/LoadGoalRequest'
CreateGoalRequest            = require 'data/requests/CreateGoalRequest'
DeleteGoalRequest            = require 'data/requests/DeleteGoalRequest'
RenameGoalRequest            = require 'data/requests/RenameGoalRequest'
ChangeGoalDescriptionRequest = require 'data/requests/ChangeGoalDescriptionRequest'
ChangeGoalStatusRequest      = require 'data/requests/ChangeGoalStatusRequest'
ChangeGoalTimeframeRequest   = require 'data/requests/ChangeGoalTimeframeRequest'

class GoalStore extends ModelStore

  displayName: 'GoalStore'
  name:        'goals'
  modelType:   Goal

  listensFor: [
    'GoalsLoaded'
    'GoalChanged'
    'GoalDeleted'
    'UserCreatedGoal'
    'UserDeletedGoal'
    'UserRenamedGoal'
    'UserChangedGoalDescription'
    'UserChangedGoalStatus'
    'UserChangedGoalTimeframe'
  ]

  load: (id) ->
    @execute new LoadGoalRequest(id)

  onGoalsLoaded: (event) ->
    @add(event.goals)

  onGoalChanged: (event) ->
    @set(event.goal.id, event.goal)

  onGoalDeleted: (event) ->
    @remove(event.goal.id)

  onUserCreatedGoal: (event) ->
    @execute new CreateGoalRequest(event.orgid, event.name, event.description, event.timeframe)

  onUserDeletedGoal: (event) ->
    @execute new DeleteGoalRequest(event.goalid)

  onUserRenamedGoal: (event) ->
    @execute new RenameGoalRequest(event.goalid, event.name)

  onUserChangedGoalDescription: (event) ->
    @execute new ChangeGoalDescriptionRequest(event.goalid, event.description)

  onUserChangedGoalStatus: (event) ->
    @execute new ChangeGoalStatusRequest(event.goalid, event.status)

  onUserChangedGoalTimeframe: (event) ->
    @execute new ChangeGoalTimeframeRequest(event.goalid, event.timeframe)

module.exports = GoalStore
