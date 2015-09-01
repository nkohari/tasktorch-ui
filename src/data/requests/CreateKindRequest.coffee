Kind             = require 'data/models/Kind'
KindCreatedEvent = require 'events/create/KindCreatedEvent'
Request          = require 'data/framework/Request'

class CreateKindRequest extends Request

  constructor: (@orgid, @name, @description, @color, @stages) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{@orgid}/kinds"))
    .withCredentials()
    .send {@name, @description, @color, @stages}
  
  onSuccess: (result, publish) ->
    card = new Kind(result.card)
    publish new KindCreatedEvent(card)

module.exports = CreateKindRequest
