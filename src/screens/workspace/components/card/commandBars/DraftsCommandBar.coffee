_                  = require 'lodash'
React              = require 'react'
CardCommand        = require 'framework/enums/CardCommand'
CardCommandContext = require '../CardCommandContext'
CommandButton      = React.createFactory(require './CommandButton')
{div}              = React.DOM

DraftsCommandBar = React.createClass {

  displayName: 'DraftsCommandBar'

  mixins: [CardCommandContext]

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        CommandButton {key: 'do',       icon: 'do',       text: 'Do',       command: CardCommand.Do}
        CommandButton {key: 'hand-off', icon: 'hand-off', text: 'Hand Off', command: CardCommand.HandOff}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CommandButton {key: 'archive',  icon: 'archive',  command: CardCommand.Archive}
        CommandButton {key: 'trash',    icon: 'trash',    command: CardCommand.Trash}
      ]
    ]

}

module.exports = DraftsCommandBar
