superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class MoveStageRequest extends Request

  constructor: (@stageid, @position) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/move"))
    .withCredentials()
    .send {@position}
    .end (err, res) =>
      stage = new Stage(res.body.stage)
      eventQueue.publish new StageChangedEvent(stage)

module.exports = MoveStageRequest
