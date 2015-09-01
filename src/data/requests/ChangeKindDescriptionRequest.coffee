Kind             = require 'data/models/Kind'
KindChangedEvent = require 'events/change/KindChangedEvent'
Request          = require 'data/framework/Request'

class ChangeKindDescriptionRequest extends Request

  constructor: (@kindid, @description) ->

  create: (agent) ->
    agent.post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/description"))
    .withCredentials()
    .send {@description}

  onSuccess: (result, publish) ->
    kind = new Kind(result.kind)
    publish new KindChangedEvent(kind)

module.exports = ChangeKindDescriptionRequest
