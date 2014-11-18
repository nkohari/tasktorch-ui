React       = require 'react'
CardCommand = require 'framework/enums/CardCommand'
Button      = React.createFactory(require 'common/Button')
{div}       = React.DOM

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  propTypes:
    showCommandPanel: React.PropTypes.func.isRequired

  render: ->

    show = (command) =>
      return () => @props.showCommandPanel(command)

    div {className: 'inbox commands'}, [
      div {key: 'left', className: 'button-group'}, [
        Button {key: 'do',        icon: 'do',        text: 'Do'}
        Button {key: 'defer',     icon: 'defer',     text: 'Defer',     onClick: show(CardCommand.Defer)}
        Button {key: 'hand-back', icon: 'hand-back', text: 'Hand Back', onClick: show(CardCommand.HandBack)}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off',  onClick: show(CardCommand.HandOff)}
      ]
      div {key: 'right', className: 'button-group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = InboxCommandBar
