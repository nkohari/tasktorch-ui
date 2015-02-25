_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
Frame            = React.createFactory(require 'ui/common/Frame')
List             = React.createFactory(require 'ui/common/List')
CardCommentBox   = React.createFactory(require 'ui/panels/card/CardCommentBox')
CardTimelineItem = React.createFactory(require 'ui/panels/card/CardTimelineItem')

CardTimeline = React.createClass {

  displayName: 'CardTimeline'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    notes: cache('notesByCard').get(@props.card.id)
  }

  render: ->

    if @state.notes?
      items = _.map @state.notes, (note) =>
        CardTimelineItem {key: note.id, card: @props.card, note}

    Frame {className: 'timeline'}, items

}

module.exports = CardTimeline
