superagent       = require 'superagent'
Kind             = require 'data/models/Kind'
KindChangedEvent = require 'events/change/KindChangedEvent'
Request          = require 'data/framework/Request'

class ChangeKindDescriptionRequest extends Request

  constructor: (@kindid, @description) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/description"))
    .withCredentials()
    .send {@description}
    .end (err, res) =>
      kind = new Kind(res.body.kind)
      eventQueue.publish new KindChangedEvent(kind)

module.exports = ChangeKindDescriptionRequest
