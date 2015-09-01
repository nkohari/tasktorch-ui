Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class RenameStageRequest extends Request

  constructor: (@stageid, @name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StageChangedEvent(stage)

module.exports = RenameStageRequest
