_                             = require 'lodash'
superagent                    = require 'superagent'
Action                        = require 'data/models/Action'
Checklist                     = require 'data/models/Checklist'
Request                       = require 'data/framework/Request'
ChecklistsLoadedEvent         = require 'events/load/ChecklistsLoadedEvent'
ChecklistsByCardLoadedEvent   = require 'events/load/ChecklistsByCardLoadedEvent'
ActionsLoadedEvent            = require 'events/load/ActionsLoadedEvent'
ActionsByChecklistLoadedEvent = require 'events/load/ActionsByChecklistLoadedEvent'

class LoadChecklistsByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/checklists?expand=actions"))
    .withCredentials()
    .end (err, res) =>

      checklists = _.map res.body.checklists,       (doc) -> new Checklist(doc)
      actions    = _.map res.body.related?.actions, (doc) -> new Action(doc)

      eventQueue.publish new ChecklistsLoadedEvent(checklists)
      eventQueue.publish new ChecklistsByCardLoadedEvent(@cardid, checklists)
      eventQueue.publish new ActionsLoadedEvent(actions) if actions?.length > 0

      lookup = _.indexBy(actions, 'id')
      for checklist in checklists
        checklistActions = _.map checklist.actions, (actionid) -> lookup[actionid]
        eventQueue.publish new ActionsByChecklistLoadedEvent(checklist.id, checklistActions)

module.exports = LoadChecklistsByCardRequest
