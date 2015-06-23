Action                    = require 'data/models/Action'
ModelStore                = require 'data/framework/ModelStore'
ChangeActionOwnerRequest  = require 'data/requests/ChangeActionOwnerRequest'
ChangeActionTextRequest   = require 'data/requests/ChangeActionTextRequest'
ChangeActionStatusRequest = require 'data/requests/ChangeActionStatusRequest'
CreateActionRequest       = require 'data/requests/CreateActionRequest'
DeleteActionRequest       = require 'data/requests/DeleteActionRequest'
MoveActionRequest         = require 'data/requests/MoveActionRequest'

class ActionStore extends ModelStore

  displayName: 'ActionStore'
  name:        'actions'
  modelType:    Action

  listensFor: [
    'ActionsLoaded'
    'ActionChanged'
    'ActionCreated'
    'ActionDeleted'
    'UserChangedActionOwner'
    'UserChangedActionText'
    'UserChangedActionStatus'
    'UserCreatedAction'
    'UserDeletedAction'
    'UserMovedAction'
  ]

  load: (id) ->
    debug.warn('ActionStore.load() was called')

  onActionsLoaded: (event) ->
    @add(event.actions)

  onActionChanged: (event) ->
    @add(event.action)

  onActionCreated: (event) ->
    @add(event.action)

  onActionDeleted: (event) ->
    @add(event.action)

  onUserChangedActionOwner: (event) ->
    @execute new ChangeActionOwnerRequest(event.actionid, event.userid)

  onUserChangedActionText: (event) ->
    @execute new ChangeActionTextRequest(event.actionid, event.text)

  onUserChangedActionStatus: (event) ->
    @execute new ChangeActionStatusRequest(event.actionid, event.status)

  onUserCreatedAction: (event) ->
    @execute new CreateActionRequest(event.checklistid, event.text)

  onUserDeletedAction: (event) ->
    @execute new DeleteActionRequest(event.actionid)

  onUserMovedAction: (event) ->
    @execute new MoveActionRequest(event.actionid, event.checklistid, event.position)

module.exports = ActionStore
