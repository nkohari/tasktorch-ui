Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class MoveActionRequest extends Request

  constructor: (@actionid, @checklistid, @position) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/actions/#{@actionid}/move"))
    .withCredentials()
    .send {checklist: @checklistid, @position}
  
  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionChangedEvent(action)

module.exports = MoveActionRequest
