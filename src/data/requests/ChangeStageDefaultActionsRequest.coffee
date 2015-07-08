superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class ChangeStageDefaultActionsRequest extends Request

  constructor: (@stageid, @defaultActions) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/defaultActions"))
    .withCredentials()
    .send {@defaultActions}
    .end (err, res) =>
      stage = new Stage(res.body.stage)
      eventQueue.publish new StageChangedEvent(stage)

module.exports = ChangeStageDefaultActionsRequest
