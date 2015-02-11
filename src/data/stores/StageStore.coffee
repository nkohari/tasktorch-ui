_                       = require 'lodash'
Store                   = require 'framework/Store'
LoadStagesByKindRequest = require 'requests/LoadStagesByKindRequest'

class StageStore extends Store

  displayName: 'StageStore'

  onKindStageListDisplayed: (event) ->
    if @getMany(event.stageids)?
      @announce()
    else
      @execute new LoadStagesByKindRequest(event.kindid)

  onStagesLoaded: (event) ->
    @add(event.stages)

module.exports = StageStore
