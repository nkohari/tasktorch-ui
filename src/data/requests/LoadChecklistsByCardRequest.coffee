_                             = require 'lodash'
Action                        = require 'data/models/Action'
Checklist                     = require 'data/models/Checklist'
Request                       = require 'data/framework/Request'
ChecklistsLoadedEvent         = require 'events/load/ChecklistsLoadedEvent'
ChecklistsByCardLoadedEvent   = require 'events/load/ChecklistsByCardLoadedEvent'
ActionsLoadedEvent            = require 'events/load/ActionsLoadedEvent'
ActionsByChecklistLoadedEvent = require 'events/load/ActionsByChecklistLoadedEvent'

class LoadChecklistsByCardRequest extends Request

  constructor: (@cardid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/cards/#{@cardid}/checklists?expand=actions"))
    .withCredentials()
  
  onSuccess: (result, publish) ->

    checklists = _.map result.checklists,       (doc) -> new Checklist(doc)
    actions    = _.map result.related?.actions, (doc) -> new Action(doc)

    publish new ChecklistsLoadedEvent(checklists)
    publish new ChecklistsByCardLoadedEvent(@cardid, checklists)
    publish new ActionsLoadedEvent(actions) if actions?.length > 0

    lookup = _.indexBy(actions, 'id')
    for checklist in checklists
      checklistActions = _.map checklist.actions, (actionid) -> lookup[actionid]
      publish new ActionsByChecklistLoadedEvent(checklist.id, checklistActions)

module.exports = LoadChecklistsByCardRequest
