React    = require 'react'
Observe  = require 'mixins/Observe'
CardBody = React.createFactory(require './CardBody')
{div}    = React.DOM

CardDetails = React.createClass {

  displayName: 'CardDetails'

  mixins: [Observe()]

  render: ->
    div {className: 'details'}, [
      CardBody {key: 'body', card: @props.card}
    ]

}

module.exports = CardDetails
