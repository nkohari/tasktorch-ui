_             = require 'lodash'
React         = require 'react'
CardCommand   = require 'framework/enums/CardCommand'
CommandButton = React.createFactory(require './CommandButton')
{div}         = React.DOM

QueueCommandBar = React.createClass {

  displayName: 'QueueCommandBar'

  propTypes:
    activeCommand: React.PropTypes.string
    showCommand:   React.PropTypes.func.isRequired

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        @makeButton {key: 'defer',    icon: 'defer',    text: 'Defer',    command: CardCommand.Defer}
        @makeButton {key: 'hand-off', icon: 'hand-off', text: 'Hand Off', command: CardCommand.HandOff}
      ]
      div {key: 'right', className: 'button-group right'}, [
        @makeButton {key: 'archive',  icon: 'archive',  command: CardCommand.Archive}
        @makeButton {key: 'trash',    icon: 'trash',    command: CardCommand.Trash}
      ]
    ]

  makeButton: (props) ->
    CommandButton _.extend props, {activeCommand: @props.activeCommand, showCommand: @props.showCommand}

}

module.exports = QueueCommandBar
