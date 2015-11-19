#--------------------------------------------------------------------------------
_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
{li, ul}  = React.DOM
#--------------------------------------------------------------------------------
require './ContextMenu.styl'
#--------------------------------------------------------------------------------

ContextMenu = React.createClass {

  displayName: 'ContextMenu'

  propTypes:
    position:    PropTypes.string
    hideOverlay: PropTypes.func

  getDefaultProps: ->
    {position: 'bottom left'}

  render: ->

    items = React.Children.map @props.children, (child) =>
      return unless child?
      # TODO: This is some hackery, but I'm not sure how else to detect the child.
      # We could switch to use a marker of some kind (like ---), but I'm not sure
      # if that's better or worse.
      if child.type.displayName == 'ContextMenuSeparator'
        child
      else
        li {className: 'menu-item', onMouseUp: @onMenuItemClicked}, child

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
