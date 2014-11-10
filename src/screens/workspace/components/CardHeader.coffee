_                  = require 'lodash'
React              = require 'react'
Flux               = require 'mixins/Flux'
Constants          = require 'framework/Constants'
Text               = React.createFactory(require 'common/Text')
CardGoal           = React.createFactory(require './CardGoal')
CardLocation       = React.createFactory(require './CardLocation')
InboxCardActions   = React.createFactory(require './actions/InboxCardActions')
QueueCardActions   = React.createFactory(require './actions/QueueCardActions')
BacklogCardActions = React.createFactory(require './actions/BacklogCardActions')
{div, em}          = React.DOM

Actions =
  Inbox:   InboxCardActions
  Queue:   QueueCardActions
  Backlog: BacklogCardActions

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Flux()]

  render: ->

    children = _.compact [
      div {key: 'title', className: 'title'}, [
        Text {key: 'title-text', placeholder: Constants.untitledCard, value: @props.card.title, save: @saveTitle}
      ]
      CardLocation {key: 'location', stackId: @props.card.stack.id}
      CardGoal {key: 'goal', goal: @props.goal} if @props.goal?
      Actions[@props.stack.kind] {key: 'actions', card: @props.card}
    ]

    div {
      className: 'header'
      style:     {borderLeftColor: '#999'}
    }, children

  saveTitle: (title) ->
    @getController().setCardTitle(@props.card, title)

}

module.exports = CardHeader
