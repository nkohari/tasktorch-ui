_     = require 'lodash'
Store = require 'framework/Store'

class StageStore extends Store

  getAllByKind: (kindId) ->
    stages = _.filter(@items, (stage) -> stage.kind == kindId)
    _.sortBy(stages, 'rank')

  onStagesLoaded: (event) ->
    @add(event.stages)

module.exports = StageStore
