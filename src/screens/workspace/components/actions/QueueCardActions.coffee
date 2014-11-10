React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

QueueCardActions = React.createClass {

  displayName: 'QueueCardActions'

  render: ->
    div {className: 'queue actions'}, [
      div {className: 'group'}, [
        Button {key: 'defer',     icon: 'defer',     text: 'Defer'}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      ]
      div {className: 'group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = QueueCardActions
