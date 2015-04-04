_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Navigator      = require 'ui/framework/mixins/Navigator'
CardPanelState = require 'ui/screens/workspace/panels/card/CardPanelState'
{div, li}      = React.DOM

Card = React.createClass {

  displayName: 'Card'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.card.kind) if @props.card?
  }

  render: ->

    classes = classSet [
      'card'
      'active'          if @getCurrentScreen().isPanelVisible(@props.card.id)
      @state.kind.color if @state.kind?
    ]

    props = mergeProps _.omit(@props, 'card'), {
      className:     classes
      'data-itemid': @props.card.id
    }

    li props, 
      div {className: 'content'},
        @props.children

}

module.exports = Card
