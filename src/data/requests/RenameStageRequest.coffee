Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class RenameStageRequest extends Request

  constructor: (@stageid, @name) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/stages/#{@stageid}/name"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StageChangedEvent(stage)

module.exports = RenameStageRequest
