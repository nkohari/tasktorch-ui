Stage             = require 'data/models/Stage'
StageDeletedEvent = require 'events/delete/StageDeletedEvent'
Request           = require 'data/framework/Request'

class DeleteStageRequest extends Request

  constructor: (@stageid, @inheritorStage) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/stages/#{@stageid}"))
    .withCredentials()
    .send {@inheritorStage}
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StageDeletedEvent(stage)

module.exports = DeleteStageRequest
