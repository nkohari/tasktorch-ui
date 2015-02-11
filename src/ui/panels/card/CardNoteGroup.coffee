_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
NoteFactory         = require './notes/NoteFactory'
ListItem            = React.createFactory(require 'ui/common/ListItem')
CardNoteGroupHeader = React.createFactory(require 'ui/panels/card/CardNoteGroupHeader')
{li, ul}            = React.DOM

CardNoteGroup = React.createClass {

  displayName: 'CardNoteGroup'

  propTypes:
    card:   PropTypes.Card
    userid: PropTypes.id
    notes:  PropTypes.arrayOf(PropTypes.Note)

  mixins: [Observe('users')]

  componentDidMount: ->
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

    ListItem {@isReady, className: 'note-group'}, [
      CardNoteGroupHeader {key: 'header', card: @props.card, notes: @props.notes, user: @state.user}
      ul {}, notes
    ]

}

module.exports = CardNoteGroup
