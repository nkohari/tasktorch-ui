_                          = require 'lodash'
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
    for note in notes
      if not currentGroup? or note.user != currentGroup.user
        group = {user: note.user, notes: [note]}
        groups.push(group)
        currentGroup = group
      else
        currentGroup.notes.push(note)
    return groups

  #--------------------------------------------------------------------------------

}

module.exports = CardNotesBlock
