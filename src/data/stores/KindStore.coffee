Kind                         = require 'data/models/Kind'
ModelStore                   = require 'data/framework/ModelStore'
CreateKindRequest            = require 'data/requests/CreateKindRequest'
ChangeKindColorRequest       = require 'data/requests/ChangeKindColorRequest'
ChangeKindDescriptionRequest = require 'data/requests/ChangeKindDescriptionRequest'
RenameKindRequest            = require 'data/requests/RenameKindRequest'

class KindStore extends ModelStore

  name:        'kinds'
  displayName: 'KindStore'
  modelType:   Kind

  listensFor: [
    'KindsLoaded'
    'KindCreated'
    'KindChanged'
    'UserChangedKindColor'
    'UserChangedKindDescription'
    'UserCreatedKind'
    'UserRenamedKind'
  ]

  load: (id) ->
    debug.warn('KindStore.load() was called')

  onKindsLoaded: (event) ->
    @add(event.kinds)

  onKindCreated: (event) ->
    @add(event.kind)

  onKindChanged: (event) ->
    @add(event.kind)

  onUserChangedKindColor: (event) ->
    @execute new ChangeKindColorRequest(event.kindid, event.color)

  onUserChangedKindDescription: (event) ->
    @execute new ChangeKindDescriptionRequest(event.kindid, event.description)

  onUserRenamedKind: (event) ->
    @execute new RenameKindRequest(event.kindid, event.name)

  onUserCreatedKind: (event) ->
    @execute new CreateKindRequest(event.orgid, event.name, event.description, event.color, event.stages)

module.exports = KindStore
