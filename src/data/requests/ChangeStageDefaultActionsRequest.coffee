Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StageChangedEvent = require 'events/change/StageChangedEvent'

class ChangeStageDefaultActionsRequest extends Request

  constructor: (@stageid, @defaultActions) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/stages/#{@stageid}/defaultActions"))
    .withCredentials()
    .send {@defaultActions}
  
  onSuccess: (result, publish) ->
    stage = new Stage(result.stage)
    publish new StageChangedEvent(stage)

module.exports = ChangeStageDefaultActionsRequest
