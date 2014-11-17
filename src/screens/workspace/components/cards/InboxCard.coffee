React     = require 'react'
Constants = require 'framework/Constants'
{div, em} = React.DOM

InboxCard = React.createClass {

  displayName: 'InboxCard'

  render: ->
    div {className: 'body inbox'}, [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, [
          'from '
          em {}, 'X'
          ' to '
          em {}, 'Y'
          ' at '
          em {}, 'Z'
        ]
      ]
      div {className: 'bottom'}, [@props.card.body]
    ]

}

module.exports = InboxCard
