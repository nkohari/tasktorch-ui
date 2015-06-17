_                      = require 'lodash'
superagent             = require 'superagent'
Note                   = require 'data/models/Note'
NotesLoadedEvent       = require 'events/load/NotesLoadedEvent'
NotesByCardLoadedEvent = require 'events/load/NotesByCardLoadedEvent'
Request                = require 'data/framework/Request'

class LoadNotesByCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/cards/#{@cardid}/notes"))
    .withCredentials()
    .end (err, res) =>
      notes = _.map res.body.notes, (doc) -> new Note(doc)
      eventQueue.publish new NotesLoadedEvent(notes)
      eventQueue.publish new NotesByCardLoadedEvent(@cardid, notes)

module.exports = LoadNotesByCardRequest
