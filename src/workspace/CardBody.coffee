React = require 'react'
{div} = React.DOM

CardBody = React.createClass {

  render: ->
    div {className: 'card-body'}, [
      @props.card.body
    ]

}

module.exports = CardBody
