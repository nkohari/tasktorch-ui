Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionStatusRequest extends Request

  constructor: (@actionid, @status) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/actions/#{@actionid}/status"))
    .withCredentials()
    .send {@status}

  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionChangedEvent(action)

module.exports = ChangeActionStatusRequest
