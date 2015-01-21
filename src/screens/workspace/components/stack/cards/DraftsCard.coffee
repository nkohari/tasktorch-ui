_         = require 'lodash'
React     = require 'react'
PropTypes = require 'common/PropTypes'
Observe   = require 'mixins/Observe'
Time      = React.createFactory(require 'common/Time')
{div}     = React.DOM

DraftsCard = React.createClass {

  displayName: 'DraftsCard'

  propTypes:
    card: PropTypes.Card

  render: ->
    move = @getLastMove(@props.card)

    div {
      className: 'summary'
      style: {borderLeftColor: @props.kind.color}
    }, [
      div {className: 'title'}, [@props.card.title or 'Untitled Card']
      div {className: 'subtitle'}, [
        Time {key: 'time', time: move.time}
      ]
    ]

  getLastMove: (card) ->
    return _.max card.moves, (move) -> moment(move.time).valueOf()

}

module.exports = DraftsCard
