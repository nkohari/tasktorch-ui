Stage             = require 'data/models/Stage'
StageCreatedEvent = require 'events/create/StageCreatedEvent'
Request           = require 'data/framework/Request'

class CreateStageRequest extends Request

  constructor: (@kindid, @name) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/stages"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    team = new Stage(result.team)
    publish new StageCreatedEvent(team)

module.exports = CreateStageRequest
