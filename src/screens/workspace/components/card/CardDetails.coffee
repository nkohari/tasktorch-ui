React       = require 'react'
Observe     = require 'mixins/Observe'
CardBody    = React.createFactory(require './CardBody')
CardActions = React.createFactory(require './CardActions')
{div}       = React.DOM

CardDetails = React.createClass {

  displayName: 'CardDetails'

  mixins: [Observe()]

  render: ->
    div {className: 'details'}, [
      CardBody {key: 'body', card: @props.card}
      CardActions {key: 'actions', card: @props.card, kind: @props.kind, overlayContainer: @props.overlayContainer}
    ]

}

module.exports = CardDetails
