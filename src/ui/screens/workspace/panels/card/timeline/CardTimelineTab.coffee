#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
CardTimelineItem = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CardTimelineItem')
{div}            = React.DOM
#--------------------------------------------------------------------------------
require './CardTimelineTab.styl'
#--------------------------------------------------------------------------------

CardTimelineTab = React.createClass {

  displayName: 'CardTimelineTab'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    notes: cache('notesByCard').get(@props.card.id)
  }

  componentDidMount: ->
    @userIsScrolling = false
    @scrollToBottom()

  componentWillReceiveProps: ->
    @scrollToBottom()

  componentDidUpdate: ->
    @scrollToBottom()

  render: ->

    items = _.map @state.notes, (note) =>
      CardTimelineItem {key: note.id, card: @props.card, note}

    div {className: 'card-timeline-tab', @onScroll},
      div {ref: 'notes', className: 'card-notes'}, items

  onScroll: ->
    node = @refs.notes.getDOMNode()
    @userIsScrolling = (node.scrollHeight - node.scrollTop != node.clientHeight)
    return

  scrollToBottom: ->
    unless @userIsScrolling
      node = @refs.notes.getDOMNode()
      node.scrollTop = node.scrollHeight

}

module.exports = CardTimelineTab
