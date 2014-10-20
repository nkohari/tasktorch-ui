React     = require 'react'
Strings   = require '../../Strings'
{div, em} = React.DOM

InboxCard = React.createClass {

  render: ->
    div {className: 'stack-card-body inbox'}, [
      div {className: 'card-top'}, [
        div {className: 'title'},   [@props.card.title or Strings.untitledCard]
        div {className: 'handoff'}, [
          'from '
          em {}, 'X'
          ' to '
          em {}, 'Y'
          ' at '
          em {}, 'Z'
        ]
      ]
      div {className: 'card-bottom'}, [@props.card.body]
    ]

}

module.exports = InboxCard
