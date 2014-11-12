_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
Constants           = require 'framework/Constants'
SetCardTitleRequest = require 'requests/SetCardTitleRequest'
Text                = React.createFactory(require 'common/Text')
InboxCardCommands   = React.createFactory(require './commands/InboxCardCommands')
QueueCardCommands   = React.createFactory(require './commands/QueueCardCommands')
BacklogCardCommands = React.createFactory(require './commands/BacklogCardCommands')
{div}               = React.DOM

Commands =
  Inbox:   InboxCardCommands
  Queue:   QueueCardCommands
  Backlog: BacklogCardCommands

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Observe()]

  render: ->
    div {
      className: 'header'
      style:     {borderTopColor: @props.kind.color}
    }, [
      div {key: 'title', className: 'title'}, [
        Text {key: 'title-text', placeholder: Constants.untitledCard, value: @props.card.title, save: @saveTitle}
      ]
      Commands[@props.stack.type] {key: 'commands', card: @props.card}
    ]

  saveTitle: (title) ->
    @execute new SetCardTitleRequest(@props.card, title)

}

module.exports = CardHeader
