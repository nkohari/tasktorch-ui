_                = require 'lodash'
superagent       = require 'superagent'
Header           = require 'framework/enums/Header'
Request          = require 'framework/Request'
Note             = require 'models/Note'
NoteCreatedEvent = require 'events/create/NoteCreatedEvent'

class CreateNoteRequest extends Request

  constructor: (@card, @type, @content) ->

  execute: (context, eventBus) ->
    superagent.post("/api/#{@card.org}/cards/#{@card.id}/notes")
    .set(Header.Socket, eventBus.getSocketId())
    .send {@type, @content}
    .end (res) =>
      eventBus.publish new NoteCreatedEvent(res.body.note)

module.exports = CreateNoteRequest
