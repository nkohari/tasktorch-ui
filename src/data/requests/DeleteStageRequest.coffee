superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
StageDeletedEvent = require 'events/delete/StageDeletedEvent'
Request           = require 'data/framework/Request'

class DeleteStageRequest extends Request

  constructor: (@stageid, @inheritorStage) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{Environment.orgid}/stages/#{@stageid}"))
    .send {@inheritorStage}
    .withCredentials()
    .end (err, res) =>
      stage = new Stage(res.body.stage)
      eventQueue.publish new StageDeletedEvent(stage)

module.exports = DeleteStageRequest
