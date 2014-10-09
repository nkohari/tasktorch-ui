React     = require 'react'
{div, em} = React.DOM

InboxCard = React.createClass {

  render: ->
    div {className: 'stack-card-body inbox'}, [
      div {className: 'card-top'}, [
        div {className: 'title'},   [@props.card.title]
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
