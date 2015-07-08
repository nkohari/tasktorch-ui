superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class RenameStageRequest extends Request

  constructor: (@stageid, @name) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/name"))
    .withCredentials()
    .send {@name}
    .end (err, res) =>
      stage = new Stage(res.body.stage)
      eventQueue.publish new StageChangedEvent(stage)

module.exports = RenameStageRequest
