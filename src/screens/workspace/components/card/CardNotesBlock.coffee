_                          = require 'lodash'
moment                     = require 'moment'
React                      = require 'react'
PropTypes                  = require 'common/PropTypes'
Observe                    = require 'mixins/Observe'
CardNoteListDisplayedEvent = require 'events/display/CardNoteListDisplayedEvent'
CardNoteGroup              = React.createFactory(require './CardNoteGroup')
{ul}                       = React.DOM

CardNotesBlock = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardNotesBlock'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe('notes')]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardNoteListDisplayedEvent(@props.card.id)

  componentWillReceiveProps: (newProps) ->
    unless @props.card.id == newProps.card.id
      @publish new CardNoteListDisplayedEvent(newProps.card.id)

  # State -------------------------------------------------------------------------
  
  sync: (stores) ->
    console.log {notes: stores.notes.getAllByCard(@props.card.id)}
    {notes: stores.notes.getAllByCard(@props.card.id)}

  ready: ->
    {notes: @state.notes?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    ul {className: 'notes'}, @contents()

  children: ->
    groups = @createGroups(@state.notes)
    _.map groups, (group) =>
      CardNoteGroup {card: @props.card, userId: group.user, notes: group.notes}

  createGroups: (notes) ->
    groups = []
    currentGroup = undefined
    currentNote  = undefined
    shouldStartNewGroup = (note) ->
      return true unless currentGroup? and currentNote?
      return true if note.user != currentNote.user
      return true if note.getTimeDifference(currentNote) > 60*5*1000 # 5 minutes
    for note in notes
      if shouldStartNewGroup(note)
        group = {user: note.user, notes: [note], time: note.time}
        groups.push(group)
        currentGroup = group
      else
        currentGroup.notes.push(note)
      currentNote = note
    return groups

  #--------------------------------------------------------------------------------

}

module.exports = CardNotesBlock
