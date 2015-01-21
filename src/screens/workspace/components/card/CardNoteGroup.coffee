_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'common/PropTypes'
Observe            = require 'mixins/Observe'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
Avatar             = React.createFactory(require 'common/Avatar')
{li, ul}           = React.DOM

NoteBody = _.memoize (type) ->
  switch type
    when 'CardCreated'        then React.createFactory(require './notes/CardCreatedNote')
    when 'CardSummaryChanged' then React.createFactory(require './notes/CardSummaryChangedNote')
    when 'CardTitleChanged'   then React.createFactory(require './notes/CardTitleChangedNote')
    else
      throw new Error("Don't know how to render a note of type #{type}")

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
      NoteBody(note.type) {key: "note-#{note.id}", card: @props.card, note: note, user: @state.user}

    return [
      Avatar {key: 'avatar', user: @state.user}
      ul {}, notes
    ]

}

module.exports = CardNoteGroup
