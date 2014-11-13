_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
KindsLoadedEvent = require 'events/KindsLoadedEvent'

class LoadAllKindsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/kinds", (res) =>
      eventBus.publish new KindsLoadedEvent(res.body)

module.exports = LoadAllKindsRequest
