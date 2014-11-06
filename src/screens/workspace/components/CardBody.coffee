React         = require 'react'
Flux          = require 'mixins/Flux'
Constants     = require 'framework/Constants'
MultilineText = React.createFactory(require 'common/MultilineText')
{div}         = React.DOM

CardBody = React.createClass {

  displayName: 'CardBody'

  mixins: [Flux()]

  render: ->
    div {className: 'card-body'}, [
      MultilineText {key: 'card-body-text', placeholder: Constants.cardBody, value: @props.card.body, save: @saveBody}
    ]

  saveBody: (value) ->
    @getController().setCardBody(@props.card, value)

}

module.exports = CardBody
