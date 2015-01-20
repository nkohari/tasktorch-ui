_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
NotesLoadedEvent = require 'events/load/NotesLoadedEvent'

class LoadNotesByCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/notes", (res) =>
      {notes} = res.body
      eventBus.publish new NotesLoadedEvent(notes)

module.exports = LoadNotesByCardRequest
