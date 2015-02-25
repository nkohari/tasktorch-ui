_                       = require 'lodash'
superagent              = require 'superagent'
Stage                   = require 'data/models/Stage'
Request                 = require 'data/framework/Request'
StagesLoadedEvent       = require 'events/load/StagesLoadedEvent'
StagesByKindLoadedEvent = require 'events/load/StagesByKindLoadedEvent'

class LoadStagesByKindRequest extends Request

  constructor: (@kindid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/kinds/#{@kindid}/stages", (res) =>
      stages = _.map res.body.stages, (data) -> new Stage(data)
      eventQueue.publish new StagesLoadedEvent(stages)
      eventQueue.publish new StagesByKindLoadedEvent(@kindid, stages)

module.exports = LoadStagesByKindRequest
