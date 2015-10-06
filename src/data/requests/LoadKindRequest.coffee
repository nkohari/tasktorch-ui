Kind             = require 'data/models/Kind'
Request          = require 'data/framework/Request'
KindsLoadedEvent = require 'events/load/KindsLoadedEvent'

class LoadKindRequest extends Request

  constructor: (@kindid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/kinds/#{@kindid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    kind = new Kind(result.kind)
    publish new KindsLoadedEvent([kind])

module.exports = LoadKindRequest
