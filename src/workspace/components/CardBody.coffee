React         = require 'react'
Flux          = require '../../mixins/Flux'
Strings       = require '../../Strings'
MultilineText = React.createFactory(require '../../common/MultilineText')
{div}         = React.DOM

CardBody = React.createClass {

  displayName: 'CardBody'

  mixins: [Flux()]

  render: ->
    div {className: 'card-body'}, [
      MultilineText {key: 'card-body-text', placeholder: Strings.cardBody, value: @props.card.body, save: @saveBody}
    ]

  saveBody: (value) ->
    @getController().setCardBody(@props.card, value)

}

module.exports = CardBody
