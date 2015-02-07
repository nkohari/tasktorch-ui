_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
NotesLoadedEvent = require 'events/load/NotesLoadedEvent'

class LoadNotesByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/cards/#{@cardid}/notes", (res) =>
      eventBus.publish new NotesLoadedEvent(res.body.notes)

module.exports = LoadNotesByCardRequest
