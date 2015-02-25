_                        = require 'lodash'
superagent               = require 'superagent'
Action                   = require 'data/models/Action'
Request                  = require 'data/framework/Request'
ActionsLoadedEvent       = require 'events/load/ActionsLoadedEvent'
ActionsByCardLoadedEvent = require 'events/load/ActionsByCardLoadedEvent'

class LoadActionsByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/cards/#{@cardid}/actions", (res) =>
      actions = _.map res.body.actions, (doc) -> new Action(doc)
      eventQueue.publish new ActionsLoadedEvent(actions)
      eventQueue.publish new ActionsByCardLoadedEvent(@cardid, actions)

module.exports = LoadActionsByCardRequest
