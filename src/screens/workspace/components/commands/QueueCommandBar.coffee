_           = require 'lodash'
React       = require 'react'
CardCommand = require 'framework/enums/CardCommand'
Button      = React.createFactory(require 'common/Button')
{div}       = React.DOM

QueueCommandBar = React.createClass {

  displayName: 'QueueCommandBar'

  propTypes:
    showCommandPanel: React.PropTypes.func.isRequired

  render: ->

    show = (command) =>
      return () => @props.showCommandPanel(command)

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        Button {key: 'defer',     icon: 'defer',     text: 'Defer',    onClick: show(CardCommand.Defer)}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off', onClick: show(CardCommand.HandOff)}
      ]
      div {key: 'right', className: 'button-group right'}, [
        Button {key: 'archive',   icon: 'archive'}
        Button {key: 'trash',     icon: 'trash'}
      ]
    ]

}

module.exports = QueueCommandBar
