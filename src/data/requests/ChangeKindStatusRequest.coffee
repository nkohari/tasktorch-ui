Kind             = require 'data/models/Kind'
KindChangedEvent = require 'events/change/KindChangedEvent'
Request          = require 'data/framework/Request'

class ChangeKindStatusRequest extends Request

  constructor: (@kindid, @status) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/kinds/#{@kindid}/status"))
    .withCredentials()
    .send {@status}
     
  onSuccess: (result, publish) ->
    kind = new Kind(result.kind)
    publish new KindChangedEvent(kind)

module.exports = ChangeKindStatusRequest
