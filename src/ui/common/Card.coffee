#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
classSet    = require 'common/util/classSet'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
ViewContext = require 'ui/framework/mixins/ViewContext'
{div, li}   = React.DOM
#--------------------------------------------------------------------------------

Card = React.createClass {

  displayName: 'Card'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, ViewContext]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.card.kind) if @props.card?
  }

  render: ->

    classes = classSet [
      'card'
      'active'                        if @isPanelOpen(@props.card.id)
      @state.kind.color.toLowerCase() if @state.kind?
    ]

    props = mergeProps _.omit(@props, 'card'), {
      className:     classes
      'data-id': @props.card.id
    }

    li props, 
      div {className: 'content'},
        @props.children

}

module.exports = Card
