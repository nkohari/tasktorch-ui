Action                    = require 'data/models/Action'
ModelStore                = require 'data/framework/ModelStore'
ChangeActionOwnerRequest  = require 'data/requests/ChangeActionOwnerRequest'
ChangeActionTextRequest   = require 'data/requests/ChangeActionTextRequest'
ChangeActionStatusRequest = require 'data/requests/ChangeActionStatusRequest'
CreateActionRequest       = require 'data/requests/CreateActionRequest'

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
  ]

  load: (id) ->
    console.warn('ActionStore.load() was called')

  onActionsLoaded: (event) ->
    @add(event.actions)

  onActionChanged: (event) ->
    @add(event.action)

  onActionCreated: (event) ->
    @add(event.action)

  onActionDeleted: (event) ->
    @add(event.action)

  onUserCreatedAction: (event) ->
    @execute new CreateActionRequest(event.cardid, event.stageid, event.text)

  onUserChangedActionOwner: (event) ->
    @execute new ChangeActionOwnerRequest(event.actionid, event.userid)

  onUserChangedActionText: (event) ->
    @execute new ChangeActionTextRequest(event.actionid, event.text)

  onUserChangedActionStatus: (event) ->
    @execute new ChangeActionStatusRequest(event.actionid, event.status)

module.exports = ActionStore
