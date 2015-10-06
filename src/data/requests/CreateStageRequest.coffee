Stage             = require 'data/models/Stage'
StageCreatedEvent = require 'events/create/StageCreatedEvent'
Request           = require 'data/framework/Request'

class CreateStageRequest extends Request

  constructor: (@kindid, @name) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/kinds/#{@kindid}/stages"))
    .withCredentials()
    .send {@name}
  
  onSuccess: (result, publish) ->
    team = new Stage(result.team)
    publish new StageCreatedEvent(team)

module.exports = CreateStageRequest
