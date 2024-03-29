Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StagesLoadedEvent = require 'events/load/StagesLoadedEvent'

class LoadStageRequest extends Request

  constructor: (@stageid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/stages/#{@stageid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StagesLoadedEvent([stage])

module.exports = LoadStageRequest
