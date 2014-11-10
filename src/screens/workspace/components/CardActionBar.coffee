React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

CardActionBar = React.createClass {

  displayName: 'CardActionBar'

  render: ->
    div {className: 'action-bar'}, [
      Button {key: 'do',        icon: 'do',        text: 'Do'}
      Button {key: 'defer',     icon: 'defer',     text: 'Defer'}
      Button {key: 'hand-back', icon: 'hand-back', text: 'Hand Back'}
      Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
      Button {key: 'archive',   icon: 'archive'}
      Button {key: 'trash',     icon: 'trash'}
    ]

}

module.exports = CardActionBar
