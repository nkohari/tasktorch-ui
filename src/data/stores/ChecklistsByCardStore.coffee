_                           = require 'lodash'
ListStore                   = require 'data/framework/ListStore'
LoadChecklistsByCardRequest = require 'data/requests/LoadChecklistsByCardRequest'

class ChecklistsByCardStore extends ListStore

  displayName: 'ChecklistsByCardStore'
  name:        'checklistsByCard'
  dependsOn:   'checklists'

  listensFor: [
    'ChecklistsByCardLoaded'
    'CardChanged'
  ]

  load: (id) ->
    @execute new LoadChecklistsByCardRequest(id)

  onChecklistsByCardLoaded: (event) ->
    @set(event.cardid, _.pluck(event.checklists, 'id'))

  onCardChanged: (event) ->
    @set(event.card.id, event.card.checklists)

module.exports = ChecklistsByCardStore
