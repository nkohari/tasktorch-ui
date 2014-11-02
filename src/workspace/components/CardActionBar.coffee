React  = require 'react'
Button = React.createFactory(require '../../common/Button')
{div}  = React.DOM

CardActionBar = React.createClass {

  displayName: 'CardActionBar'

  render: ->
    div {className: 'action-bar'}, [
      Button {key: 'accept',    icon: 'accept',    text: 'Accept'}
      Button {key: 'hand-back', icon: 'hand-back', text: 'Hand Back'}
      Button {key: 'hand-off',  icon: 'hand-off',  text: 'Hand Off'}
    ]

}

module.exports = CardActionBar
