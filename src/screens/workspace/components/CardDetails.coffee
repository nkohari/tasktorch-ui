React            = require 'react'
Flux             = require 'mixins/Flux'
CardBody         = React.createFactory(require './CardBody')
CardParticipants = React.createFactory(require './CardParticipants')
{div}            = React.DOM

CardDetails = React.createClass {

  displayName: 'CardDetails'

  mixins: [Flux()]

  render: ->
    div {className: 'details'}, [
      CardParticipants {key: 'participants', card: @props.card, participants: @props.participants}
      CardBody {key: 'body', card: @props.card}
    ]

}

module.exports = CardDetails
