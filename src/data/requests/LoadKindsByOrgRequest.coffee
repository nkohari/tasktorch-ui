_                     = require 'lodash'
Kind                  = require 'data/models/Kind'
KindsLoadedEvent      = require 'events/load/KindsLoadedEvent'
KindsByOrgLoadedEvent = require 'events/load/KindsByOrgLoadedEvent'
Request               = require 'data/framework/Request'

class LoadKindsByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{@orgid}/kinds"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    kinds = _.map result.kinds, (doc) -> new Kind(doc)
    publish new KindsLoadedEvent(kinds)
    publish new KindsByOrgLoadedEvent(@orgid, kinds)

module.exports = LoadKindsByOrgRequest
