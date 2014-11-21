_                  = require 'lodash'
React              = require 'react'
CardCommand        = require 'framework/enums/CardCommand'
CardCommandContext = require '../CardCommandContext'
CommandButton      = React.createFactory(require './CommandButton')
{div}              = React.DOM

QueueCommandBar = React.createClass {

  displayName: 'QueueCommandBar'

  mixins: [CardCommandContext]

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        CommandButton {key: 'defer',    icon: 'defer',    text: 'Defer',    command: CardCommand.Defer}
        CommandButton {key: 'hand-off', icon: 'hand-off', text: 'Hand Off', hotkey: 'h', command: CardCommand.HandOff}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CommandButton {key: 'archive',  icon: 'archive',  command: CardCommand.Archive}
        CommandButton {key: 'trash',    icon: 'trash',    command: CardCommand.Trash}
      ]
    ]

}

module.exports = QueueCommandBar
