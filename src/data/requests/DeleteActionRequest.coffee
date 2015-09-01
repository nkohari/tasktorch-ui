Action             = require 'data/models/Action'
ActionDeletedEvent = require 'events/delete/ActionDeletedEvent'
Request            = require 'data/framework/Request'

class DeleteActionRequest extends Request

  constructor: (@actionid) ->

  create: (agent) ->
    agent
    .del(@urlFor("/#{Environment.orgid}/actions/#{@actionid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionDeletedEvent(action)

module.exports = DeleteActionRequest
