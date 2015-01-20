_                          = require 'lodash'
React                      = require 'react'
PropTypes                  = require 'common/PropTypes'
Observe                    = require 'mixins/Observe'
CardNoteListDisplayedEvent = require 'events/display/CardNoteListDisplayedEvent'
CardNoteListItem           = React.createFactory(require './CardNoteListItem')
{ul}                       = React.DOM

CardNoteList = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardNoteList'

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
    _.map @state.notes, (note) =>
      CardNoteListItem {key: "note-#{note.id}", card: @props.card, note: note}

  #--------------------------------------------------------------------------------

}

module.exports = CardNoteList
