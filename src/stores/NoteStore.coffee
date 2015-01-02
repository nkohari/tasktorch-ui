_        = require 'lodash'
moment   = require 'moment'
Store    = require 'framework/Store'
NoteType = require 'framework/enums/NoteType'

class NoteStore extends Store

  getAllByCard: (cardId) ->
    notes = _.filter(@items, (note) -> note.card == cardId)
    _.sortBy notes, (note) -> moment(note).valueOf()

  getMostRecentPassByCard: (cardId) ->
    notes = _.filter @items, (note) -> note.card == cardId and note.type == NoteType.Passed
    if notes.length == 0
      return null
    else
      _.max notes, (note) -> moment(note).valueOf()

  onNotesLoaded: (event) ->
    @add(event.notes)

module.exports = NoteStore
