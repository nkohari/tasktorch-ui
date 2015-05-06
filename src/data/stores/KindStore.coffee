Kind              = require 'data/models/Kind'
ModelStore        = require 'data/framework/ModelStore'
CreateKindRequest = require 'data/requests/CreateKindRequest'

class KindStore extends ModelStore

  name:        'kinds'
  displayName: 'KindStore'
  modelType:   Kind

  listensFor: [
    'KindsLoaded'
    'KindCreated'
    'KindChanged'
    'UserCreatedKind'
  ]

  load: (id) ->
    console.warn('KindStore.load() was called')

  onKindsLoaded: (event) ->
    @add(event.kinds)

  onKindCreated: (event) ->
    @add(event.kind)

  onKindChanged: (event) ->
    @add(event.kind)

  onUserCreatedKind: (event) ->
    @execute new CreateKindRequest(event.orgid, event.name, event.description, event.color, event.stages)

module.exports = KindStore
