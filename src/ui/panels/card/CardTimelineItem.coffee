React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
{div}       = React.DOM

NoteComponents =
  ActionCreated:      React.createFactory(require 'ui/panels/card/timeline/notes/ActionCreatedNote')
  ActionOwnerChanged: React.createFactory(require 'ui/panels/card/timeline/notes/ActionOwnerChangedNote')
  ActionTextChanged:  React.createFactory(require 'ui/panels/card/timeline/notes/ActionTextChangedNote')
  CardAccepted:       React.createFactory(require 'ui/panels/card/timeline/notes/CardAcceptedNote')
  CardCreated:        React.createFactory(require 'ui/panels/card/timeline/notes/CardCreatedNote')
  CardMoved:          React.createFactory(require 'ui/panels/card/timeline/notes/CardMovedNote')
  CardPassed:         React.createFactory(require 'ui/panels/card/timeline/notes/CardPassedNote')
  CardTitleChanged:   React.createFactory(require 'ui/panels/card/timeline/notes/CardTitleChangedNote')
  CardSummaryChanged: React.createFactory(require 'ui/panels/card/timeline/notes/CardSummaryChangedNote')
  Comment:            React.createFactory(require 'ui/panels/card/timeline/notes/CommentNote')

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
