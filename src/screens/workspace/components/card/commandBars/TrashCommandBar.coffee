_                  = require 'lodash'
React              = require 'react'
CardCommand        = require 'framework/enums/CardCommand'
CardCommandContext = require '../CardCommandContext'
CommandButton      = React.createFactory(require './CommandButton')
{div}              = React.DOM

TrashCommandBar = React.createClass {

  displayName: 'TrashCommandBar'

  mixins: [CardCommandContext]

  render: ->

    div {className: 'archive commands'}, [
      div {key: 'left', className: 'button-group'}, [
        CommandButton {key: 'restore', icon: 'restore', text: 'Restore', command: CardCommand.Restore}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CommandButton {key: 'archive', icon: 'archive', command: CardCommand.Archive}
      ]
    ]

}

module.exports = TrashCommandBar
