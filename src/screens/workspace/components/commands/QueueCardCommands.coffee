React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

QueueCardCommands = React.createClass {

  displayName: 'QueueCardCommands'

  render: ->
    div {className: 'queue commands'}, [
      div {key: 'left', className: 'group'}, [
        Button {key: 'defer',     icon: 'defer',     text: 'Defer'}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      ]
      div {key: 'right', className: 'group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = QueueCardCommands
