Stage            = require 'data/models/Stage'
ModelStore       = require 'data/framework/ModelStore'
LoadStageRequest = require 'data/requests/LoadStageRequest'

class StageStore extends ModelStore

  displayName: 'StageStore'
  name:        'stages'
  modelType:   Stage

  listensFor: [
    'StagesLoaded'
    'StageCreated'
    'StageChanged'
  ]

  load: (id) ->
    @execute new LoadStageRequest(id)

  onStagesLoaded: (event) ->
    @add(event.stages)

  onStageChanged: (event) ->
    @add(event.stage)

  onStageCreated: (event) ->
    @add(event.stage)

module.exports = StageStore
