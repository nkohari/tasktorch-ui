React = require 'react'
Icon  = require './Icon'
{div, span} = React.DOM

PanelHeader = React.createClass {

  render: ->
    children = []
    children.push(@createIcon()) if @props.icon?
    children.push(span {className: 'title'}, [@props.title])
    children.push(@createCloseButton()) if @props.onClose?
    div {className: 'header'}, children

  createIcon: ->
    Icon {name: @props.icon}

  createCloseButton: ->
    span {className: 'close', onClick: @props.onClose}, [
      Icon {name: 'close'}
    ]

}

module.exports = PanelHeader
