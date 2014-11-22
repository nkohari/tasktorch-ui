React     = require 'react'
Constants = require 'framework/Constants'
{div}     = React.DOM

InboxCard = React.createClass {

  displayName: 'InboxCard'

  render: ->

    div {className: 'summary'}, [
      div {
        className: 'indicator'
        style: {borderColor: @props.kind.color}
      }
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, [
          'November 21'
        ]
      ]
      div {className: 'bottom'}, [@props.card.body]
    ]

}

module.exports = InboxCard
