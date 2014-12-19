React     = require 'react'
Constants = require 'framework/Constants'
Observe   = require 'mixins/Observe'
StackCard = React.createFactory(require '../StackCard')
Time      = React.createFactory(require 'common/Time')
{div}     = React.DOM

DraftsCard = React.createClass {

  displayName: 'DraftsCard'

  render: ->
    StackCard {card: @props.card}, [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, ['handoff']
      ]
      div {className: 'bottom'}, [@props.card.body]
    ]

}

module.exports = DraftsCard
