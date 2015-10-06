_                             = require 'lodash'
Action                        = require 'data/models/Action'
Request                       = require 'data/framework/Request'
ActionsLoadedEvent            = require 'events/load/ActionsLoadedEvent'
ActionsByChecklistLoadedEvent = require 'events/load/ActionsByChecklistLoadedEvent'

class LoadActionsByChecklistRequest extends Request

  constructor: (@checklistid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/checklists/#{@checklistid}/actions"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    actions = _.map result.actions, (doc) -> new Action(doc)
    publish new ActionsLoadedEvent(actions)
    publish new ActionsByChecklistLoadedEvent(@checklistid, actions)

module.exports = LoadActionsByChecklistRequest
