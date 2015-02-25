_                     = require 'lodash'
superagent            = require 'superagent'
Kind                  = require 'data/models/Kind'
KindsLoadedEvent      = require 'events/load/KindsLoadedEvent'
KindsByOrgLoadedEvent = require 'events/load/KindsByOrgLoadedEvent'
Request               = require 'data/framework/Request'

class LoadKindsByOrgRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{@orgid}/kinds", (res) =>
      kinds = _.map res.body.kinds, (doc) -> new Kind(doc)
      eventQueue.publish new KindsLoadedEvent(kinds)
      eventQueue.publish new KindsByOrgLoadedEvent(@orgid, kinds)

module.exports = LoadKindsByOrgRequest
