_                           = require 'lodash'
DocumentStatus              = require 'data/enums/DocumentStatus'
ListStore                   = require 'data/framework/ListStore'
LoadChecklistsByCardRequest = require 'data/requests/LoadChecklistsByCardRequest'

class ChecklistsByCardStore extends ListStore

  displayName: 'ChecklistsByCardStore'
  name:        'checklistsByCard'
  dependsOn:   'checklists'

  listensFor: [
    'ChecklistChanged'
    'ChecklistCreated'
    'ChecklistsByCardLoaded'
  ]

  load: (id) ->
    @execute new LoadChecklistsByCardRequest(id)

  onChecklistChanged: (event) ->
    # TODO: This should really be a "deleted" event
    if event.checklist.status is DocumentStatus.Deleted
      @remove(event.checklist.card)

  onChecklistCreated: (event) ->
    @remove(event.checklist.card)

  onChecklistsByCardLoaded: (event) ->
    @set(event.cardid, _.map(event.checklists, 'id'))

module.exports = ChecklistsByCardStore
