React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{li}      = React.DOM

ContextMenuSeparator = React.createClass {

  displayName: 'ContextMenuSeparator'

  render: ->
    li {className: 'separator'}

}

module.exports = ContextMenuSeparator
