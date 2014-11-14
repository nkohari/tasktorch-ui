_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StagesLoadedEvent = require 'events/StagesLoadedEvent'

class LoadStagesByKindRequest extends Request

  constructor: (@kindId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/kinds/#{@kindId}/stages", (res) =>
      eventBus.publish new StagesLoadedEvent(res.body)

module.exports = LoadStagesByKindRequest
