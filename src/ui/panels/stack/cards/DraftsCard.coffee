_         = require 'lodash'
moment    = require 'moment'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
Observe   = require 'framework/mixins/Observe'
Time      = React.createFactory(require 'ui/common/Time')
{div}     = React.DOM

DraftsCard = React.createClass {

  displayName: 'DraftsCard'

  propTypes:
    card: PropTypes.Card

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

module.exports = DraftsCard
