_                  = require 'lodash'
React              = require 'react'
CardCommand        = require 'framework/enums/CardCommand'
CardCommandContext = require '../CardCommandContext'
CommandButton      = React.createFactory(require './CommandButton')
{div}              = React.DOM

ArchiveCommandBar = React.createClass {

  displayName: 'ArchiveCommandBar'

  mixins: [CardCommandContext]

  render: ->

    div {className: 'archive commands'}, [
      div {key: 'left', className: 'button-group'}, [
        CommandButton {key: 'restore', icon: 'restore', text: 'Restore', command: CardCommand.Restore}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CommandButton {key: 'trash',    icon: 'trash',    command: CardCommand.Trash}
      ]
    ]

}

module.exports = ArchiveCommandBar
