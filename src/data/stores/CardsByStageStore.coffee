_                       = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadCardsByStageRequest = require 'data/requests/LoadCardsByStageRequest'

class CardsByStageStore extends ListStore

  displayName: 'CardsByStageStore'
  name:        'cardsByStage'
  dependsOn:   'cards'

  listensFor: [
    'CardsByStageLoaded'
    'ActionChanged'
    'ActionDeleted'
  ]

  load: (id) ->
    @execute new LoadCardsByStageRequest(id)

  onCardsByStageLoaded: (event) ->
    @set(event.stageid, _.pluck(event.cards, 'id'))

  # TODO: There's currently no way to know which lists should be invalidated,
  # so we just wipe the whole board clean and start over. Revisit if possible.

  onActionChanged: (event) ->
    @clear()

  onActionDeleted: (event) ->
    @clear()

module.exports = CardsByStageStore
