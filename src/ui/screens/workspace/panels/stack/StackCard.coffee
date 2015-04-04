_              = require 'lodash'
moment         = require 'moment'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
CardPanelState = require 'ui/screens/workspace/panels/card/CardPanelState'
Card           = React.createFactory(require 'ui/common/Card')
Time           = React.createFactory(require 'ui/common/Time')
{div}          = React.DOM

StackCard = React.createClass {

  displayName: 'StackCard'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  mixins: [Navigator]

  render: ->

    move = @getLastMove(@props.card)

    Card {className: 'stack-card', card: @props.card, onClick: @showCard},
      div {className: 'title'},
        @props.card.title or 'Untitled Card'
      div {className: 'subtitle'},
        Time {time: move.time}

  getLastMove: (card) ->
    return _.max card.moves, (move) -> moment(move.time).valueOf()

  showCard: ->
    @getScreen('workspace').addPanelAfter(@props.stack.id, new CardPanelState(@props.card.id))

}

module.exports = StackCard
