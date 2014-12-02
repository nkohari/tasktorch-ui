React = require 'react'
{div} = React.DOM

Tooltip = React.createClass {

  displayName: 'Tooltip'

  render: ->

    style =
      position: 'absolute'
      zIndex:   100000
      left:     @props.position.left
      top:      @props.position.top

    div {
      className: 'tooltip'
      style
    }, [
      @props.text
    ]

}

module.exports = Tooltip
