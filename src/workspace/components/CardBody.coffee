React         = require 'react'
MultilineText = require '../../common/MultilineText'
Flux          = require '../../mixins/Flux'
Strings       = require '../../Strings'
{div}         = React.DOM

CardBody = React.createClass {

  mixins: [Flux()]

  render: ->
    div {className: 'card-body'}, [
      MultilineText {placeholder: Strings.cardBody, value: @props.card.body, save: @saveBody}
    ]

  saveBody: (value) ->
    @getController().setCardBody(@props.card, value)

}

module.exports = CardBody
