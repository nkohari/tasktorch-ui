_     = require 'lodash'
Store = require 'framework/Store'

class StageStore extends Store

  constructor: ->
    @stages = {}

  getStage: (id) ->
    @stages[id]

  getStagesByKind: (kindId) ->
    stages = _.filter(@stages, (stage) -> stage.kind.id == kindId)
    _.sortBy(stages, 'rank')

  onStagesLoaded: (event) ->
    @stages = _.extend @stages, _.indexBy(event.stages, 'id')
    @announce()

module.exports = StageStore
