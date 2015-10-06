_                      = require 'lodash'
Note                   = require 'data/models/Note'
NotesLoadedEvent       = require 'events/load/NotesLoadedEvent'
NotesByCardLoadedEvent = require 'events/load/NotesByCardLoadedEvent'
Request                = require 'data/framework/Request'

class LoadNotesByCardRequest extends Request

  constructor: (@cardid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/cards/#{@cardid}/notes"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    notes = _.map result.notes, (doc) -> new Note(doc)
    publish new NotesLoadedEvent(notes)
    publish new NotesByCardLoadedEvent(@cardid, notes)

module.exports = LoadNotesByCardRequest
