React     = require 'react'
Constants = require 'framework/Constants'
{div, em} = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  render: ->
    div {className: 'body queue'}, [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, [
          'in queue since '
          em {}, 'X'
        ]
      ]
      div {className: 'bottom'}, [@props.card.body]
    ]

}

module.exports = QueueCard
