_         = require 'lodash'
moment    = require 'moment'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Pure      = require 'ui/framework/mixins/Pure'
Time      = React.createFactory(require 'ui/common/Time')
{div}     = React.DOM

InboxCard = React.createClass {

  displayName: 'InboxCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Pure]

  render: ->
    
    move = @getLastMove(@props.card)
    style = {borderLeftColor: @props.kind.color}

    div {className: 'summary', style},
      div {className: 'title'},
        @props.card.title or 'Untitled Card'
      div {className: 'subtitle'},
        Time {time: move.time}

  getLastMove: (card) ->
    return _.max card.moves, (move) -> moment(move.time).valueOf()

}

module.exports = InboxCard
