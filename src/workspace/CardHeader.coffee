React     = require 'react'
Text      = require '../common/Text'
Api       = require '../Api'
Strings   = require '../Strings'
{div, em} = React.DOM

CardHeader = React.createClass {

  render: ->
    div {className: 'card-header'}, [
      div {className: 'type'}, [@props.card.type?.name]
      div {className: 'title'}, [
        Text {placeholder: Strings.untitledCard, value: @props.card.title, save: @saveTitle}
      ]
      div {className: 'handoff'}, [
        'in '
        em {}, 'X'
        ' since '
        em {}, 'Yesterday'
      ]
    ]

  saveTitle: (title) ->
    Api.setCardTitle(@props.card, title)

}

module.exports = CardHeader
