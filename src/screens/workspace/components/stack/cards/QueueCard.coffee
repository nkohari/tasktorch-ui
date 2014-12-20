React     = require 'react'
Constants = require 'framework/Constants'
Observe   = require 'mixins/Observe'
StackCard = React.createFactory(require '../StackCard')
{div}     = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  render: ->
    StackCard {card: @props.card}, [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, ['in queue since X']
      ]
      div {className: 'bottom'}, [@props.card.body]
    ]

}

module.exports = QueueCard
