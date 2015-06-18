#--------------------------------------------------------------------------------
_              = require 'lodash'
moment         = require 'moment'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
CardPanelState = require 'ui/screens/workspace/panels/card/CardPanelState'
Card           = React.createFactory(require 'ui/common/Card')
{div}          = React.DOM
#--------------------------------------------------------------------------------
require './StackCard.styl'
#--------------------------------------------------------------------------------

StackCard = React.createClass {

  displayName: 'StackCard'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  mixins: [Navigator]

  render: ->

    Card {className: 'stack-card', card: @props.card, onClick: @showCard},
      div {className: 'title'},
        @props.card.title or 'Untitled Card'

  showCard: ->
    @getScreen('workspace').addPanelAfter(@props.stack.id, new CardPanelState(@props.card.id))

}

module.exports = StackCard
