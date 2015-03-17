_                           = require 'lodash'
superagent                  = require 'superagent'
Checklist                   = require 'data/models/Checklist'
Request                     = require 'data/framework/Request'
ChecklistsLoadedEvent       = require 'events/load/ChecklistsLoadedEvent'
ChecklistsByCardLoadedEvent = require 'events/load/ChecklistsByCardLoadedEvent'

class LoadChecklistsByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get "/api/#{Environment.orgid}/cards/#{@cardid}/checklists", (res) =>
      checklists = _.map res.body.checklists, (doc) -> new Checklist(doc)
      eventQueue.publish new ChecklistsLoadedEvent(checklists)
      eventQueue.publish new ChecklistsByCardLoadedEvent(@cardid, checklists)

module.exports = LoadChecklistsByCardRequest
