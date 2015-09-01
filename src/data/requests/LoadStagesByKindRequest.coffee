_                       = require 'lodash'
Stage                   = require 'data/models/Stage'
Request                 = require 'data/framework/Request'
StagesLoadedEvent       = require 'events/load/StagesLoadedEvent'
StagesByKindLoadedEvent = require 'events/load/StagesByKindLoadedEvent'

class LoadStagesByKindRequest extends Request

  constructor: (@kindid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/stages"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stages = _.map result.stages, (data) -> new Stage(data)
    publish new StagesLoadedEvent(stages)
    publish new StagesByKindLoadedEvent(@kindid, stages)

module.exports = LoadStagesByKindRequest
