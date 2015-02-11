_                      = require 'lodash'
moment                 = require 'moment'
Store                  = require 'framework/Store'
NoteType               = require 'framework/enums/NoteType'
LoadNotesByCardRequest = require 'requests/LoadNotesByCardRequest'

class NoteStore extends Store

  displayName: 'NoteStore'

  getAllByCard: (cardid) ->
    notes = _.filter(@items, (note) -> note.card == cardid)
    _.sortBy notes, (note) -> moment(note).valueOf()

  getMostRecentPassByCard: (cardid) ->
    notes = _.filter @items, (note) -> note.card == cardid and note.type == NoteType.Passed
    if notes.length == 0
      return null
    else
      _.max notes, (note) -> moment(note).valueOf()

  onCardNoteListDisplayed: (event) ->
    # TODO: Detect if we've already loaded the notes
    @execute new LoadNotesByCardRequest(event.cardid)

  onNoteCreated: (event) ->
    @add(event.note)

  onNotesLoaded: (event) ->
    @add(event.notes)

module.exports = NoteStore
