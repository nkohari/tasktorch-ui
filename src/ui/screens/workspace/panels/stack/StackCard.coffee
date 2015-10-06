#--------------------------------------------------------------------------------
_                    = require 'lodash'
moment               = require 'moment'
React                = require 'react'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CardPanelSpec        = require 'ui/framework/panels/CardPanelSpec'
Card                 = React.createFactory(require 'ui/common/Card')
{div}                = React.DOM
#--------------------------------------------------------------------------------
require './StackCard.styl'
#--------------------------------------------------------------------------------

StackCard = React.createClass {

  displayName: 'StackCard'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  mixins: [Actor]

  render: ->

    Card {className: 'stack-card', card: @props.card, onClick: @showCard},
      div {className: 'title'},
        @props.card.title or 'Untitled Card'

  showCard: ->
    @publish new UserOpenedPanelEvent(new CardPanelSpec(@props.card.id), {after: @props.stack.id})

}

module.exports = StackCard
