_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
NoteFactory         = require './notes/NoteFactory'
CardNoteGroupHeader = React.createFactory(require './CardNoteGroupHeader')
{li, ul}            = React.DOM

CardNoteGroup = React.createClass {

  displayName: 'CardNoteGroup'

  propTypes:
    card:   PropTypes.Card
    userId: PropTypes.id
    notes:  PropTypes.arrayOf(PropTypes.Note)

  mixins: [Observe('users')]

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.userId)

  componentWillReceiveProps: (newProps) ->
    if @props.userId != newProps.userId
      @publish new UserDisplayedEvent(newProps.userId)

  sync: (stores) ->
    {user: stores.users.get(@props.userId)}

  ready: ->
    {user: @state.user?}

  render: ->
    li {className: 'note-group'}, @contents()

  children: ->

    notes = _.map @props.notes, (note) =>
      NoteFactory(note.type) {key: "note-#{note.id}", card: @props.card, note: note, user: @state.user}

    return [
      CardNoteGroupHeader {key: 'header', card: @props.card, notes: @props.notes, user: @state.user}
      ul {}, notes
    ]

}

module.exports = CardNoteGroup
