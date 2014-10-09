React = require 'react'
{div} = React.DOM

QueueCard = React.createClass {

  render: ->
    div {className: 'stack-card-body queue'}, [
      div {className: 'card subject'}, [@props.card.title]
      div {className: 'card body'}, [@props.card.body]
    ]

}

module.exports = QueueCard
