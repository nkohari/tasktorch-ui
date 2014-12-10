_         = require 'lodash'
React     = require 'react'
QueueCard = React.createFactory(require './QueueCard')
{ul}      = React.DOM

QueueCardList = React.createClass {

  displayName: 'QueueCardList'

  render: ->
    ul {className: 'queue cards'}, @renderChildren()

  renderChildren: ->
    _.map @props.cards, (card) =>
      QueueCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = QueueCardList
