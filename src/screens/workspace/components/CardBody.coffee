React              = require 'react'
Observe            = require 'mixins/Observe'
Constants          = require 'framework/Constants'
SetCardBodyRequest = require 'requests/SetCardBodyRequest'
MultilineText      = React.createFactory(require 'common/MultilineText')
{div}              = React.DOM

CardBody = React.createClass {

  displayName: 'CardBody'

  mixins: [Observe()]

  render: ->
    div {className: 'body'}, [
      MultilineText {key: 'text', placeholder: Constants.cardBody, value: @props.card.body, save: @saveBody}
    ]

  saveBody: (value) ->
    @execute new SetCardBodyRequest(@props.card, value)

}

module.exports = CardBody
