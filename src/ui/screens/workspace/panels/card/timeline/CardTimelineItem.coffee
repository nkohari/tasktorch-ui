#--------------------------------------------------------------------------------
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
{div}       = React.DOM
#--------------------------------------------------------------------------------

NoteComponents =
  ActionCreated:       React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActionCreatedNote')
  ActionMoved:         React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActionMovedNote')
  ActionOwnerChanged:  React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActionOwnerChangedNote')
  ActionStatusChanged: React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActionStatusChangedNote')
  ActionTextChanged:   React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActionTextChangedNote')
  CardAccepted:        React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardAcceptedNote')
  CardCompleted:       React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardCompletedNote')
  CardCreated:         React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardCreatedNote')
  CardDueDateChanged:  React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardDueDateChangedNote')
  CardEffortChanged:   React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardEffortChangedNote')
  CardMoved:           React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardMovedNote')
  CardPassed:          React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardPassedNote')
  CardRestored:        React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardRestoredNote')
  CardTitleChanged:    React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardTitleChangedNote')
  CardSummaryChanged:  React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CardSummaryChangedNote')
  Comment:             React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/CommentNote')
  FileAddedToCard:     React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/FileAddedToCardNote')
  FileRemovedFromCard: React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/FileRemovedFromCardNote')
  FollowerAdded:       React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/FollowerAddedNote')
  FollowerRemoved:     React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/FollowerRemovedNote')

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
      debug.warn("Don't know how to render a note of type #{@props.note.type}")
      return div {}

    NoteComponent {card: @props.card, note: @props.note, user: @state.user}

}

module.exports = CardTimelineItem
