_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
KindsLoadedEvent = require 'events/load/KindsLoadedEvent'

class LoadAllKindsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/kinds", (res) =>
      {kinds} = res.body
      eventBus.publish new KindsLoadedEvent(kinds)

module.exports = LoadAllKindsRequest
