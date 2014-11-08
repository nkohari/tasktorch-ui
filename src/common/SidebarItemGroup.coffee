_         = require 'lodash'
React     = require 'react'
{div, ul} = React.DOM

SidebarItemGroup = React.createClass {

  displayName: 'SidebarItemGroup'

  render: ->
    div {className: 'group'}, [
      div {key: 'header', className: 'header'}, [@props.header]
      ul {key: 'items'}, @props.children
    ]

}

module.exports = SidebarItemGroup
