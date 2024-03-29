Action             = require 'data/models/Action'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
Request            = require 'data/framework/Request'

class ChangeActionTextRequest extends Request

  constructor: (@actionid, @text) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{identity.orgid}/actions/#{@actionid}/text"))
    .withCredentials()
    .send {@text}

  onSuccess: (result, publish) ->
    action = new Action(result.action)
    publish new ActionChangedEvent(action)

module.exports = ChangeActionTextRequest
