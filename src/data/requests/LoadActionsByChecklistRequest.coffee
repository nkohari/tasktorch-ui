_                             = require 'lodash'
superagent                    = require 'superagent'
Action                        = require 'data/models/Action'
Request                       = require 'data/framework/Request'
ActionsLoadedEvent            = require 'events/load/ActionsLoadedEvent'
ActionsByChecklistLoadedEvent = require 'events/load/ActionsByChecklistLoadedEvent'

class LoadActionsByChecklistRequest extends Request

  constructor: (@checklistid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/checklists/#{@checklistid}/actions"))
    .withCredentials()
    .end (err, res) =>
      actions = _.map res.body.actions, (doc) -> new Action(doc)
      eventQueue.publish new ActionsLoadedEvent(actions)
      eventQueue.publish new ActionsByChecklistLoadedEvent(@checklistid, actions)

module.exports = LoadActionsByChecklistRequest
