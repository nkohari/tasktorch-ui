_                      = require 'lodash'
ListStore              = require 'data/framework/ListStore'
LoadGoalsByCardRequest = require 'data/requests/LoadGoalsByCardRequest'

class GoalsByCardStore extends ListStore

  displayName: 'GoalsByCardStore'
  name:        'goalsByCard'
  dependsOn:   'goals'

  listensFor: [
    'GoalsByCardLoaded'
    'CardChanged'
  ]

  load: (id) ->
    @execute new LoadGoalsByCardRequest(id)

  onGoalsByCardLoaded: (event) ->
    @set(event.cardid, _.pluck(event.goals, 'id'))

  onCardChanged: (event) ->
    @set(event.card.id, event.card.goals)

module.exports = GoalsByCardStore
