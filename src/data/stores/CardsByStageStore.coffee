_                       = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadCardsByStageRequest = require 'data/requests/LoadCardsByStageRequest'

class CardsByStageStore extends ListStore

  displayName: 'CardsByStageStore'
  name:        'cardsByStage'
  dependsOn:   'cards'

  listensFor: [
    'CardsByStageLoaded'
    'CardChanged'
  ]

  load: (id) ->
    @execute new LoadCardsByStageRequest(id)

  onCardsByStageLoaded: (event) ->
    @set(event.stageid, _.map(event.cards, 'id'))

  # TODO: To avoid purging the entire cache, we need a copy of the previous version
  # of the document. This is sent when the change is remote (from the watcher), but
  # not on a local change.
  
  onCardChanged: (event) ->
    @clear()

module.exports = CardsByStageStore
