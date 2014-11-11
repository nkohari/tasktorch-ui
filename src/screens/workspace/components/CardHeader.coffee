_                  = require 'lodash'
React              = require 'react'
Flux               = require 'mixins/Flux'
Constants          = require 'framework/Constants'
Text               = React.createFactory(require 'common/Text')
InboxCardActions   = React.createFactory(require './actions/InboxCardActions')
QueueCardActions   = React.createFactory(require './actions/QueueCardActions')
BacklogCardActions = React.createFactory(require './actions/BacklogCardActions')
{div}              = React.DOM

Actions =
  Inbox:   InboxCardActions
  Queue:   QueueCardActions
  Backlog: BacklogCardActions

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Flux()]

  render: ->
    div {
      className: 'header'
      style:     {borderTopColor: '#099'} # TODO: Color should match the card's type
    }, [
      div {key: 'title', className: 'title'}, [
        Text {key: 'title-text', placeholder: Constants.untitledCard, value: @props.card.title, save: @saveTitle}
      ]
      Actions[@props.stack.kind] {key: 'actions', card: @props.card}
    ]

  saveTitle: (title) ->
    @getController().setCardTitle(@props.card, title)

}

module.exports = CardHeader
