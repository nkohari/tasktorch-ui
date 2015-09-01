Note             = require 'data/models/Note'
NoteCreatedEvent = require 'events/create/NoteCreatedEvent'
Request          = require 'data/framework/Request'

class CreateNoteRequest extends Request

  constructor: (@cardid, @type, @content) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/notes"))
    .withCredentials()
    .send {@type, @content}
  
  onSuccess: (result, publish) ->
    note = new Note(result.note)
    publish new NoteCreatedEvent(note)

module.exports = CreateNoteRequest
