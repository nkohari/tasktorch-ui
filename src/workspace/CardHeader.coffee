React = require 'react'
{div, em} = React.DOM

CardHeader = React.createClass {

  render: ->
    div {className: 'card-header'}, [
      div {className: 'type'},    [@props.card.type?.name]
      div {className: 'title'},   [@props.card.title]
      div {className: 'handoff'}, [
        'in '
        em {}, 'X'
        ' since '
        em {}, 'Yesterday'
      ]
    ]

}

module.exports = CardHeader
