Action             = require 'data/models/Action'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'
Request            = require 'data/framework/Request'

class CreateActionRequest extends Request

  constructor: (@checklistid, @text) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/checklists/#{@checklistid}/actions"))
    .withCredentials()
    .send {@text}
  
  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionCreatedEvent(action)

module.exports = CreateActionRequest
