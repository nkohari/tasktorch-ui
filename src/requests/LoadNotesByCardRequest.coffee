_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
NotesLoadedEvent = require 'events/load/NotesLoadedEvent'

class LoadNotesByCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/notes", (res) =>
      eventBus.publish new NotesLoadedEvent(res.body.notes)

module.exports = LoadNotesByCardRequest
