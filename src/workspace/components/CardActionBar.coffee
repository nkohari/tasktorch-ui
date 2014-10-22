React  = require 'react'
Button = require '../../common/Button'
{div}  = React.DOM

CardActionBar = React.createClass {

  render: ->
    div {className: 'action-bar'}, [
      Button {icon: 'accept',    text: 'Accept'}
      Button {icon: 'hand-back', text: 'Hand Back'}
      Button {icon: 'hand-off',  text: 'Hand Off'}
    ]

}

module.exports = CardActionBar
