superagent       = require 'superagent'
Kind             = require 'data/models/Kind'
Request          = require 'data/framework/Request'
KindChangedEvent = require 'events/change/KindChangedEvent'

class RenameKindRequest extends Request

  constructor: (@kindid, @name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/name"))
    .withCredentials()
    .send {@name}
    .end (err, res) =>
      kind = new Kind(res.body.kind)
      eventQueue.publish new KindChangedEvent(kind)

module.exports = RenameKindRequest
