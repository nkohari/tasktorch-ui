Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class MoveStageRequest extends Request

  constructor: (@stageid, @position) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/move"))
    .withCredentials()
    .send {@position}
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StageChangedEvent(stage)

module.exports = MoveStageRequest
