_                          = require 'lodash'
React                      = require 'react'
PropTypes                  = require 'common/PropTypes'
Observe                    = require 'mixins/Observe'
CardNoteListDisplayedEvent = require 'events/display/CardNoteListDisplayedEvent'
Frame                      = React.createFactory(require 'common/Frame')
CardNoteGroup              = React.createFactory(require './CardNoteGroup')
CardBlockHeader            = React.createFactory(require './CardBlockHeader')
{div, ul}                  = React.DOM

CardConversationBlock = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardConversationBlock'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe('notes')]

  getInitialState: ->
    {expanded: true}

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardNoteListDisplayedEvent(@props.card.id)

  componentDidMount: ->
    @scrollToBottom()

  componentWillReceiveProps: (newProps) ->
    unless @props.card.id == newProps.card.id
      @publish new CardNoteListDisplayedEvent(newProps.card.id)

  componentDidUpdate: ->
    @scrollToBottom()

  # State -------------------------------------------------------------------------
  
  sync: (stores) ->
    {notes: stores.notes.getAllByCard(@props.card.id)}

  isReady: ->
    @state.notes?

  # Rendering ---------------------------------------------------------------------

  render: ->

    groups = _.map @createGroups(@state.notes), (group) =>
      CardNoteGroup {card: @props.card, userid: group.user, notes: group.notes}

    div {className: 'conversation block'}, [
      CardBlockHeader {key: 'header'}, ['Conversation']
      Frame {@isReady, ref: 'contents', className: 'contents'}, [
        ul {key: 'notes', className: 'notes'}, groups
      ]
    ]

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

  scrollToBottom: ->
    node = @refs.contents.getDOMNode()
    node.scrollTop = node.scrollHeight

  #--------------------------------------------------------------------------------

}

module.exports = CardConversationBlock
