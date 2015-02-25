Kind       = require 'data/models/Kind'
ModelStore = require 'data/framework/ModelStore'

class KindStore extends ModelStore

  name:        'kinds'
  displayName: 'KindStore'
  modelType:   Kind

  listensFor: [
    'KindsLoaded'
  ]

  load: (id) ->
    console.warn('KindStore.load() was called')

  onKindsLoaded: (event) ->
    @add(event.kinds)

module.exports = KindStore
