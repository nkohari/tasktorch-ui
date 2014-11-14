React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

BacklogCardCommands = React.createClass {

  displayName: 'BacklogCardCommands'

  render: ->
    div {className: 'backlog commands'}, [
      div {key: 'left', className: 'button-group'}, [
        Button {key: 'do',        icon: 'do',        text: 'Do'}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = BacklogCardCommands
