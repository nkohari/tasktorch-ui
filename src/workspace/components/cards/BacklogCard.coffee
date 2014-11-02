React = require 'react'
{div} = React.DOM

BacklogCard = React.createClass {

  displayName: 'BacklogCard'

  render: ->
    div {className: 'stack-card-body backlog'}, [
      div {className: 'card subject'}, [@props.card.title]
      div {className: 'card body'}, [@props.card.body]
    ]

}

module.exports = BacklogCard
