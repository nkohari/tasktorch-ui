React     = require 'react'
Text      = require '../../common/Text'
Flux      = require '../../mixins/Flux'
Api       = require '../../Api'
Strings   = require '../../Strings'
{div, em} = React.DOM

CardHeader = React.createClass {

  mixins: [Flux()]

  render: ->
    div {className: 'card-header'}, [
      div {className: 'type'}, [@props.type.name]
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
    @getController().setCardTitle(@props.card, title)

}

module.exports = CardHeader
