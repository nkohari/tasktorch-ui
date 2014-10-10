React     = require 'react'
{div, em} = React.DOM

QueueCard = React.createClass {

  render: ->
    div {className: 'stack-card-body queue'}, [
      div {className: 'card-top'}, [
        div {className: 'title'},   [@props.card.title]
        div {className: 'handoff'}, [
          'in queue since '
          em {}, 'X'
        ]
      ]
      div {className: 'card-bottom'}, [@props.card.body]
    ]

}

module.exports = QueueCard
