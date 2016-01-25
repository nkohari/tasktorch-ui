Kind                         = require 'data/models/Kind'
ModelStore                   = require 'data/framework/ModelStore'
CreateKindRequest            = require 'data/requests/CreateKindRequest'
ChangeKindColorRequest       = require 'data/requests/ChangeKindColorRequest'
ChangeKindDescriptionRequest = require 'data/requests/ChangeKindDescriptionRequest'
ChangeKindStatusRequest      = require 'data/requests/ChangeKindStatusRequest'
LoadKindRequest              = require 'data/requests/LoadKindRequest'
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
    'UserChangedKindStatus'
    'UserCreatedKind'
    'UserRenamedKind'
  ]

  load: (kindid) ->
    @execute new LoadKindRequest(kindid)

  onKindsLoaded: (event) ->
    @add(event.kinds)

  onKindCreated: (event) ->
    @add(event.kind)

  onKindChanged: (event) ->
    @add(event.kind)

  onUserCreatedKind: (event) ->
    @execute new CreateKindRequest(event.orgid, event.name, event.description, event.color, event.stages)

  onUserChangedKindColor: (event) ->
    @execute new ChangeKindColorRequest(event.kindid, event.color)

  onUserChangedKindDescription: (event) ->
    @execute new ChangeKindDescriptionRequest(event.kindid, event.description)

  onUserChangedKindStatus: (event) ->
    @execute new ChangeKindStatusRequest(event.kindid, event.status)

  onUserRenamedKind: (event) ->
    @execute new RenameKindRequest(event.kindid, event.name)

module.exports = KindStore
