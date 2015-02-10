_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
NoteFactory         = require './notes/NoteFactory'
Frame               = React.createFactory(require 'common/Frame')
CardNoteGroupHeader = React.createFactory(require './CardNoteGroupHeader')
{li, ul}            = React.DOM

CardNoteGroup = React.createClass {

  displayName: 'CardNoteGroup'

  propTypes:
    card:   PropTypes.Card
    userid: PropTypes.id
    notes:  PropTypes.arrayOf(PropTypes.Note)

  mixins: [Observe('users')]

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.userid)

  componentWillReceiveProps: (newProps) ->
    if @props.userid != newProps.userid
      @publish new UserDisplayedEvent(newProps.userid)

  sync: (stores) ->
    {user: stores.users.get(@props.userid)}

  isReady: ->
    @state.user?

  render: ->

    notes = _.map @props.notes, (note) =>
      NoteFactory(note.type) {key: "note-#{note.id}", card: @props.card, note: note, user: @state.user}

    Frame {@isReady, component: 'li', className: 'note-group'}, [
      CardNoteGroupHeader {key: 'header', card: @props.card, notes: @props.notes, user: @state.user}
      ul {}, notes
    ]

}

module.exports = CardNoteGroup
