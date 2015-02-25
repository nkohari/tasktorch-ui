Note              = require 'data/models/Note'
ModelStore        = require 'data/framework/ModelStore'
CreateNoteRequest = require 'data/requests/CreateNoteRequest'

class NoteStore extends ModelStore

  displayName: 'NoteStore'
  name:        'notes'
  modelType:   Note

  listensFor: [
    'NotesLoaded'
    'NoteCreated'
    'UserCreatedComment'
  ]

  load: (id) ->
    console.warn('NoteStore.load() was called')

  onNotesLoaded: (event) ->
    @add(event.notes)

  onNoteCreated: (event) ->
    @add(event.note)

  onUserCreatedComment: (event) ->
    @execute new CreateNoteRequest(event.cardid, 'Comment', event.content)

module.exports = NoteStore
