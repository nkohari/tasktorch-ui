React     = require 'react'
Constants = require 'framework/Constants'
Observe   = require 'mixins/Observe'
StackCard = React.createFactory(require '../StackCard')
{div}     = React.DOM

BacklogCard = React.createClass {

  displayName: 'BacklogCard'

  isReady: ->
    true # TODO

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    StackCard {card: @props.card}, @getChildren()

  renderChildren: ->
    return [
      div {className: 'top'}, [
        div {className: 'title'},   [@props.card.title or Constants.untitledCard]
        div {className: 'handoff'}, ['created on X']
      ]
      div {className: 'bottom'}, ['...']
    ]

}

module.exports = BacklogCard
