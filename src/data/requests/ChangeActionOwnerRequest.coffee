Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionOwnerRequest extends Request

  constructor: (@actionid, @userid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/actions/#{@actionid}/user"))
    .withCredentials()
    .send {user: @userid}

  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionChangedEvent(action)

module.exports = ChangeActionOwnerRequest
