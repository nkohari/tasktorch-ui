_                           = require 'lodash'
ListStore                   = require 'data/framework/ListStore'
LoadChecklistsByCardRequest = require 'data/requests/LoadChecklistsByCardRequest'

class ChecklistsByCardStore extends ListStore

  displayName: 'ChecklistsByCardStore'
  name:        'checklistsByCard'
  dependsOn:   'checklists'

  listensFor: [
    'ChecklistsByCardLoaded'
  ]

  load: (id) ->
    @execute new LoadChecklistsByCardRequest(id)

  onChecklistsByCardLoaded: (event) ->
    @set(event.cardid, _.pluck(event.checklists, 'id'))

module.exports = ChecklistsByCardStore
