_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StagesLoadedEvent = require 'events/load/StagesLoadedEvent'

class LoadStagesByKindRequest extends Request

  constructor: (@kindId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/kinds/#{@kindId}/stages", (res) =>
      {stages} = res.body
      eventBus.publish new StagesLoadedEvent(stages)

module.exports = LoadStagesByKindRequest
