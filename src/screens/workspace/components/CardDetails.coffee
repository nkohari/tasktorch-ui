React    = require 'react'
Flux     = require 'mixins/Flux'
CardBody = React.createFactory(require './CardBody')
{div}    = React.DOM

CardDetails = React.createClass {

  displayName: 'CardDetails'

  mixins: [Flux()]

  render: ->
    div {className: 'details'}, [
      CardBody {key: 'body', card: @props.card}
    ]

}

module.exports = CardDetails
