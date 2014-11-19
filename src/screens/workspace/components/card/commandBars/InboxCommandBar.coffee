React              = require 'react'
CardCommand        = require 'framework/enums/CardCommand'
CardCommandContext = require '../CardCommandContext'
CommandButton      = React.createFactory(require './CommandButton')
{div}              = React.DOM

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  mixins: [CardCommandContext]

  render: ->

    div {className: 'inbox commands'}, [
      div {key: 'left', className: 'button-group'}, [
        CommandButton {key: 'do',        icon: 'do',        text: 'Do',        command: CardCommand.Do}
        CommandButton {key: 'defer',     icon: 'defer',     text: 'Defer',     command: CardCommand.Defer}
        CommandButton {key: 'hand-back', icon: 'hand-back', text: 'Hand Back', command: CardCommand.HandBack}
        CommandButton {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off',  command: CardCommand.HandOff}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CommandButton {key: 'archive',   icon: 'archive', command: CardCommand.Archive}
        CommandButton {key: 'trash',     icon: 'trash',   command: CardCommand.Trash}
      ]
    ]


}

module.exports = InboxCommandBar
