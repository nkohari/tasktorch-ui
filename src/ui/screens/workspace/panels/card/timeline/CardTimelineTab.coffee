_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
CachedState       = require 'ui/framework/mixins/CachedState'
List              = React.createFactory(require 'ui/common/List')
CardTimelineItem  = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CardTimelineItem')
CreateCommentForm = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CreateCommentForm')
{div}             = React.DOM

CardTimelineTab = React.createClass {

  displayName: 'CardTimelineTab'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    notes: cache('notesByCard').get(@props.card.id)
  }

  componentDidMount: ->
    @scrollToBottom()

  componentDidUpdate: ->
    @scrollToBottom()

  render: ->

    items = _.map @state.notes, (note) =>
      CardTimelineItem {key: note.id, card: @props.card, note}

    div {className: 'card-timeline-tab', @onScroll},
      div {className: 'card-notes'}, items
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

module.exports = CardTimelineTab
