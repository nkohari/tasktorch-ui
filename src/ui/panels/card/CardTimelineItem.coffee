React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
{div}       = React.DOM

NoteComponents =
  CardCreated:      React.createFactory(require 'ui/panels/card/notes/CardCreatedNote')
  CardTitleChanged: React.createFactory(require 'ui/panels/card/notes/CardTitleChangedNote')
  Comment:          React.createFactory(require 'ui/panels/card/notes/CommentNote')

CardTimelineItem = React.createClass {

  displayName: 'CardTimelineItem'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.note.user)
  }

  render: ->

    return div {} unless @state.user?

    NoteComponent = NoteComponents[@props.note.type]

    unless NoteComponent?
      console.warn("Don't know how to render a note of type #{@props.note.type}")
      return div {}

    NoteComponent {card: @props.card, note: @props.note, user: @state.user}

}

module.exports = CardTimelineItem
