_                      = require 'lodash'
ListStore              = require 'data/framework/ListStore'
LoadCardsByGoalRequest = require 'data/requests/LoadCardsByGoalRequest'

class CardsByGoalStore extends ListStore

  displayName: 'CardsByGoalStore'
  name:        'cardsByGoal'
  dependsOn:   'cards'

  listensFor: [
    'CardsByGoalLoaded'
    'CardChanged'
  ]

  load: (id) ->
    @execute new LoadCardsByGoalRequest(id)

  onCardsByGoalLoaded: (event) ->
    @set(event.goalid, _.map(event.cards, 'id'))

  onCardChanged: (event) ->
    for goalid in event.card.goals
      @remove(goalid)
    for goalid, cardids of @lists
      if _.includes(cardids, event.card.id) and not _.includes(event.card.goals, goalid)
        @remove(goalid)

module.exports = CardsByGoalStore
