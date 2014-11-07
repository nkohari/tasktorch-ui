React     = require 'react'
Flux      = require 'mixins/Flux'
Constants = require 'framework/Constants'
Text      = React.createFactory(require 'common/Text')
{div, em} = React.DOM

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Flux()]

  render: ->
    div {className: 'card-header'}, [
      div {key: 'card-title', className: 'title'}, [
        Text {key: 'card-title-text', placeholder: Constants.untitledCard, value: @props.card.title, save: @saveTitle}
      ]
    ]

  saveTitle: (title) ->
    @getController().setCardTitle(@props.card, title)

}

module.exports = CardHeader