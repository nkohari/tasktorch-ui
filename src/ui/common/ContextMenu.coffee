_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
{li, ul}  = React.DOM

ContextMenu = React.createClass {

  displayName: 'ContextMenu'

  propTypes:
    position:    PropTypes.string
    hideOverlay: PropTypes.func

  getDefaultProps: ->
    {position: 'bottom left'}

  render: ->

    items = React.Children.map @props.children, (child) =>
      li {className: 'menu-item', onClick: @onMenuItemClicked}, child

    classes = classSet [
      'overlay'
      'menu'
      @props.position
    ]

    ul {className: classes}, items

  onMenuItemClicked: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @props.hideOverlay()

}

module.exports = ContextMenu
