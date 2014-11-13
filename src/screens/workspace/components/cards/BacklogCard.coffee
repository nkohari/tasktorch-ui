React = require 'react'
{div} = React.DOM

BacklogCard = React.createClass {

  displayName: 'BacklogCard'

  render: ->
    div {
      style: {borderColor: @props.kind.color}
      className: 'body backlog'
    }, [
      div {className: 'card subject'}, [@props.card.title]
      div {className: 'card body'}, [@props.card.body]
    ]

}

module.exports = BacklogCard
