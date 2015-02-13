_         = require 'lodash'
React     = require 'react'
{div, ul} = React.DOM

SidebarItemGroup = React.createClass {

  displayName: 'SidebarItemGroup'

  render: ->

    div {className: 'group'},
      div {className: 'header'}, @props.header
      ul {}, @props.children

}

module.exports = SidebarItemGroup
