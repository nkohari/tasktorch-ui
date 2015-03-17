_                             = require 'lodash'
ListStore                     = require 'data/framework/ListStore'
LoadActionsByChecklistRequest = require 'data/requests/LoadActionsByChecklistRequest'

class ActionsByChecklistStore extends ListStore

  displayName: 'ActionsByChecklistStore'
  name:        'actionsByChecklist'
  dependsOn:   'actions'

  listensFor: [
    'ActionsByChecklistLoaded'
    'ChecklistChanged'
  ]

  load: (id) ->
    @execute new LoadActionsByChecklistRequest(id)

  onActionsByChecklistLoaded: (event) ->
    @set(event.checklistid, _.pluck(event.actions, 'id'))

  onChecklistChanged: (event) ->
    @set(event.checklist.id, event.checklist.actions)

module.exports = ActionsByChecklistStore
