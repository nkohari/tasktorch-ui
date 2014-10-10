React    = require 'react'
Icon     = require './Icon'
{button} = React.DOM

Button = React.createClass {

  render: ->
    button {onClick: @props.onClick}, [
      Icon {name: @props.icon}
      @props.text
    ]

}

module.exports = Button
