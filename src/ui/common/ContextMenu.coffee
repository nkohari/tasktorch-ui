_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{li, ul}  = React.DOM

ContextMenu = React.createClass {

  displayName: 'ContextMenu'

  propTypes:
    hide: PropTypes.func

  render: ->

    items = React.Children.map @props.children, (child) =>
      li {className: 'menu-item', onClick: @onMenuItemClicked}, child

    ul {className: 'overlay menu'}, items

  onMenuItemClicked: (event) ->
    @props.hide()
    event.stopPropagation()
    event.preventDefault()

}

module.exports = ContextMenu
