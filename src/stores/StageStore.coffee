_                       = require 'lodash'
Store                   = require 'framework/Store'
LoadStagesByKindRequest = require 'requests/LoadStagesByKindRequest'

class StageStore extends Store

  getAllByKind: (kindId) ->
    stages = _.filter(@items, (stage) -> stage.kind == kindId)
    _.sortBy(stages, 'rank')

  onKindStageListDisplayed: (event) ->
    if @getMany(event.stageIds)?
      @announce()
    else
      @execute new LoadStagesByKindRequest(event.kindId)

  onStagesLoaded: (event) ->
    @add(event.stages)

module.exports = StageStore
