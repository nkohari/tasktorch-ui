_         = require 'lodash'
React     = require 'react'
{div, ul} = React.DOM

SidebarSection = React.createClass {

  displayName: 'SidebarSection'

  render: ->
    div {className: 'section'}, [
      div {key: 'header', className: 'header'}, [@props.header]
      ul {key: 'items'}, @props.children
    ]

}

module.exports = SidebarSection
