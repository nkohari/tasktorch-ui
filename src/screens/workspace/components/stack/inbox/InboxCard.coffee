React     = require 'react'
Constants = require 'framework/Constants'
Observe   = require 'mixins/Observe'
StackCard = React.createFactory(require '../StackCard')
Time      = React.createFactory(require 'common/Time')
{div}     = React.DOM

InboxCard = React.createClass {

  displayName: 'InboxCard'

  mixins: [Observe('handoffs')]

  getStateFromStores: (stores) ->
    {handoff: stores.handoffs.getHandoff(@props.card.lastHandoff)}

  isReady: ->
    @state.handoff? or not @props.card.lastHandoff?

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    StackCard {card: @props.card}, @getChildren()

  renderChildren: ->
    return [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, [Time {time: @state.handoff.timestamp}]
      ]
      div {className: 'bottom'}, [@state.handoff.message]
    ]

}

module.exports = InboxCard
