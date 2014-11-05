React  = require 'react'
Router = require 'react-router'
_      = require 'lodash'
Icon   = React.createFactory(require './Icon')
Link   = React.createFactory(Router.Link)
{div, span} = React.DOM

PanelHeader = React.createClass {

  displayName: 'PanelHeader'

  render: ->
    children = []
    children.push(@createIcon()) if @props.icon?
    children.push(span {key: 'panel-title', className: 'title'}, [@props.panelTitle])
    children.push(@createCloseButton(@props.close)) if @props.close?
    div {className: 'header'}, children

  createIcon: ->
    Icon {key: 'panel-icon', name: @props.icon}

  createCloseButton: (props) ->
    props = _.extend props, {key: 'panel-close-button', className: 'close'}
    Link props, [
      Icon {key: 'panel-close-button-icon', name: 'close'}
    ]

}

module.exports = PanelHeader
