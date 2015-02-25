Stage      = require 'data/models/Stage'
ModelStore = require 'data/framework/ModelStore'

class StageStore extends ModelStore

  displayName: 'StageStore'
  name:        'stages'
  modelType:   Stage

  listensFor: [
    'StagesLoaded'
  ]

  load: (id) ->
    console.warn('StageStore.load() was called')

  onStagesLoaded: (event) ->
    @add(event.stages)

module.exports = StageStore
