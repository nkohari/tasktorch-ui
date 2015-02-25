superagent       = require 'superagent'
Note             = require 'data/models/Note'
NoteCreatedEvent = require 'events/create/NoteCreatedEvent'
Request          = require 'data/framework/Request'

class CreateNoteRequest extends Request

  constructor: (@cardid, @type, @content) ->

  execute: (eventQueue) ->
    superagent.post("/api/#{Environment.orgid}/cards/#{@cardid}/notes")
    .send {@type, @content}
    .end (res) =>
      note = new Note(res.body.note)
      eventQueue.publish new NoteCreatedEvent(note)

module.exports = CreateNoteRequest
