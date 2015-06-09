_                     = require 'lodash'
ListStore             = require 'data/framework/ListStore'
LoadGoalsByOrgRequest = require 'data/requests/LoadGoalsByOrgRequest'

class GoalsByOrgStore extends ListStore

  displayName: 'GoalsByOrgStore'
  name:        'goalsByOrg'
  dependsOn:   'goals'

  listensFor: [
    'GoalsByOrgLoaded'
    'GoalCreated'
  ]

  load: (id) ->
    @execute new LoadGoalsByOrgRequest(id)

  onGoalsByOrgLoaded: (event) ->
    goals = _.sortBy event.goals, (goal) -> goal.name.toLowerCase()
    @set(event.orgid, _.pluck(goals, 'id'))

  onGoalCreated: (event) ->
    @remove(event.goal.org)

module.exports = GoalsByOrgStore
