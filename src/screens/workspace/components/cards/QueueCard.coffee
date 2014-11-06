React     = require 'react'
Constants = require 'framework/Constants'
{div, em} = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  render: ->
    div {className: 'stack-card-body queue'}, [
      div {className: 'card-top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, [
          'in queue since '
          em {}, 'X'
        ]
      ]
      div {className: 'card-bottom'}, [@props.card.body]
    ]

}

module.exports = QueueCard
