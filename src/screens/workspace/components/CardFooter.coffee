React            = require 'react'
Observe          = require 'mixins/Observe'
Icon             = React.createFactory(require 'common/Icon')
Button           = React.createFactory(require 'common/Button')
CardParticipants = React.createFactory(require './CardParticipants')
{div, textarea}  = React.DOM

CardFooter = React.createClass {

  displayName: 'CardFooter'

  mixins: [Observe()]

  render: ->
    div {className: 'footer'}, [
      CardParticipants {key: 'participants', card: @props.card}
      div {className: 'button-group right'}, [
        Button {key: 'add-comment', icon: 'add-comment'}
        Button {key: 'add-file', icon: 'add-file'}
      ]
    ]

}

module.exports = CardFooter
