_                       = require 'lodash'
Store                   = require 'framework/Store'
LoadStagesByKindRequest = require 'requests/LoadStagesByKindRequest'

class StageStore extends Store

  displayName: 'StageStore'

  onKindStageListDisplayed: (event) ->
    if @getMany(event.stageIds)?
      @announce()
    else
      @execute new LoadStagesByKindRequest(event.kindId)

  onStagesLoaded: (event) ->
    @add(event.stages)

module.exports = StageStore
