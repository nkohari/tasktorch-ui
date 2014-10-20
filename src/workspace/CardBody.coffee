React         = require 'react'
MultilineText = require '../common/MultilineText'
Api           = require '../Api'
Strings       = require '../Strings'
{div}         = React.DOM

CardBody = React.createClass {

  render: ->
    div {className: 'card-body'}, [
      MultilineText {placeholder: Strings.cardBody, value: @props.card.body, save: @saveBody}
    ]

  saveBody: (value) ->
    Api.setCardBody(@props.card, value)

}

module.exports = CardBody
