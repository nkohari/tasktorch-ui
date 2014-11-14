React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

InboxCardCommands = React.createClass {

  displayName: 'InboxCardCommands'

  render: ->
    div {className: 'inbox commands'}, [
      div {key: 'left', className: 'button-group'}, [
        Button {key: 'do',        icon: 'do',        text: 'Do'}
        Button {key: 'defer',     icon: 'defer',     text: 'Defer'}
        Button {key: 'hand-back', icon: 'hand-back', text: 'Hand Back'}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = InboxCardCommands
