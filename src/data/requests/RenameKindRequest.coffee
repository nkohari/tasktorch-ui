Kind             = require 'data/models/Kind'
Request          = require 'data/framework/Request'
KindChangedEvent = require 'events/change/KindChangedEvent'

class RenameKindRequest extends Request

  constructor: (@kindid, @name) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/kinds/#{@kindid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    kind = new Kind(result.kind)
    publish new KindChangedEvent(kind)

module.exports = RenameKindRequest
