React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

BacklogCardActions = React.createClass {

  displayName: 'BacklogCardActions'

  render: ->
    div {className: 'backlog actions'}, [
      div {className: 'group'}, [
        Button {key: 'do',        icon: 'do',        text: 'Do'}
        Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      ]
      div {className: 'group right'}, [
        Button {key: 'archive',   icon: 'archive',   className: 'right'}
        Button {key: 'trash',     icon: 'trash',     className: 'right'}
      ]
    ]

}

module.exports = BacklogCardActions
