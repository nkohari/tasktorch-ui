_           = require 'lodash'
moment      = require 'moment'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Pure        = require 'ui/framework/mixins/Pure'
Time        = React.createFactory(require 'ui/common/Time')
{div, li}   = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.card.kind)
  }

  isReady: ->
    @state.kind?

  render: ->

    style = {borderLeftColor: @state.kind?.color}

    li {},
      div {className: 'queue-card', style},
        div {className: 'title'}, @props.card.title or 'Untitled Card'

}

module.exports = QueueCard
