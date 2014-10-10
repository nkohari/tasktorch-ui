React  = require 'react'
_      = require 'lodash'
Icon   = require './Icon'
{Link} = require 'react-router'
{div, span} = React.DOM

PanelHeader = React.createClass {

  render: ->
    children = []
    children.push(@createIcon()) if @props.icon?
    children.push(span {className: 'title'}, [@props.panelTitle])
    children.push(@createCloseButton(@props.close)) if @props.close?
    div {className: 'header'}, children

  createIcon: ->
    Icon {name: @props.icon}

  createCloseButton: (props) ->
    props = _.extend(props, {className: 'close'})
    Link props, [
      Icon {name: 'close'}
    ]

}

module.exports = PanelHeader
