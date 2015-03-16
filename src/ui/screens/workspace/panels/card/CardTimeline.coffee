_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
CachedState       = require 'ui/framework/mixins/CachedState'
Frame             = React.createFactory(require 'ui/common/Frame')
List              = React.createFactory(require 'ui/common/List')
CardTimelineItem  = React.createFactory(require 'ui/screens/workspace/panels/card/CardTimelineItem')
CreateCommentForm = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CreateCommentForm')
{div}             = React.DOM

CardTimeline = React.createClass {

  displayName: 'CardTimeline'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    notes = cache('notesByCard').get(@props.card.id)
    if notes?
      console.log "Got #{notes.length} notes for #{@props.card.id}"
    else
      console.log "No notes for #{@props.card.id}"
    {notes}

  componentDidMount: ->
    @scrollToBottom()

  componentDidUpdate: ->
    @scrollToBottom()

  render: ->

    if @state.notes?
      items = _.map @state.notes, (note) =>
        CardTimelineItem {key: note.id, card: @props.card, note}

    Frame {className: 'timeline', @onScroll},
      div {className: 'notes'}, items
      CreateCommentForm {card: @props.card, currentUser: @props.currentUser}

  onScroll: ->
    node = @getDOMNode()
    @userIsScrolling = (node.scrollHeight - node.scrollTop == node.clientHeight)
    return

  scrollToBottom: ->
    unless @userIsScrolling
      node = @getDOMNode()
      node.scrollTop = node.scrollHeight

}

module.exports = CardTimeline
