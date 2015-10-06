Kind             = require 'data/models/Kind'
KindChangedEvent = require 'events/change/KindChangedEvent'
Request          = require 'data/framework/Request'

class ChangeKindColorRequest extends Request

  constructor: (@kindid, @color) ->

  create: (identity, agent) ->
    agent.post(@urlFor("/#{identity.orgid}/kinds/#{@kindid}/color"))
    .withCredentials()
    .send {@color}

  onSuccess: (result, publish) ->
    kind = new Kind(result.kind)
    publish new KindChangedEvent(kind)

module.exports = ChangeKindColorRequest
