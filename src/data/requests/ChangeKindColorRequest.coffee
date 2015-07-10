superagent       = require 'superagent'
Kind             = require 'data/models/Kind'
KindChangedEvent = require 'events/change/KindChangedEvent'
Request          = require 'data/framework/Request'

class ChangeKindColorRequest extends Request

  constructor: (@kindid, @color) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/color"))
    .withCredentials()
    .send {@color}
    .end (err, res) =>
      kind = new Kind(res.body.kind)
      eventQueue.publish new KindChangedEvent(kind)

module.exports = ChangeKindColorRequest
