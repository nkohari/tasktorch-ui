_                      = require 'lodash'
ListStore              = require 'data/framework/ListStore'
LoadNotesByCardRequest = require 'data/requests/LoadNotesByCardRequest'

class NotesByCardStore extends ListStore

  displayName: 'NotesByCardStore'
  name:        'notesByCard'
  dependsOn:   'notes'

  listensFor: [
    'NotesByCardLoaded'
    'NoteCreated'
  ]

  load: (id) ->
    @execute new LoadNotesByCardRequest(id)

  onNotesByCardLoaded: (event) ->
    @set(event.cardid, _.map(event.notes, 'id'))

  onNoteCreated: (event) ->
    list = @lists[event.note.card]
    if list?
      newList = list.concat [event.note.id]
      @set(event.note.card, newList)

module.exports = NotesByCardStore
