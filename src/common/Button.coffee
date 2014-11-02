React = require 'react'
Icon = React.createFactory(require './Icon')
{span, button} = React.DOM

Button = React.createClass {

  displayName: 'Button'

  render: ->
    button {onClick: @props.onClick}, [
      Icon {key: 'button-icon', name: @props.icon}
      span {key: 'button-text'}, @props.text
    ]

}

module.exports = Button
