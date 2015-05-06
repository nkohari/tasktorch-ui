superagent       = require 'superagent'
Kind             = require 'data/models/Kind'
KindCreatedEvent = require 'events/create/KindCreatedEvent'
Request          = require 'data/framework/Request'

class CreateKindRequest extends Request

  constructor: (@orgid, @name, @description, @color, @stages) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{@orgid}/kinds")
    .send {@name, @description, @color, @stages}
    .end (res) =>
      card = new Kind(res.body.card)
      eventQueue.publish new KindCreatedEvent(card)

module.exports = CreateKindRequest
