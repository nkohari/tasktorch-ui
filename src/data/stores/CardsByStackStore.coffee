_                       = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadCardsByStackRequest = require 'data/requests/LoadCardsByStackRequest'

class CardsByStackStore extends ListStore

  displayName: 'CardsByStackStore'
  name:        'cardsByStack'
  dependsOn:   'cards'

  listensFor: [
    'CardsByStackLoaded'
    'StackChanged'
  ]

  load: (id) ->
    @execute new LoadCardsByStackRequest(id)

  onCardsByStackLoaded: (event) ->
    @set(event.stackid, _.pluck(event.cards, 'id'))

  onStackChanged: (event) ->
    @set(event.stack.id, event.stack.cards)

module.exports = CardsByStackStore
