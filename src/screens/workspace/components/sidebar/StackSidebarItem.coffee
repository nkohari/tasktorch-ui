_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'common/PropTypes'
StackType    = require 'framework/enums/StackType'
WorkspaceUrl = require 'framework/urls/WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Hotlink      = React.createFactory(require 'common/Hotlink')
{li, span}   = React.DOM

StackSidebarItem = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackSidebarItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Router.State]

  # Rendering ---------------------------------------------------------------------

  render: ->
    li {className: 'sidebar-item'}, [
      Hotlink @makeLinkProps(), [
        Icon {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
        span {key: 'name', className: 'name'}, [@getStackName()]
        span {key: 'count', className: 'count'}, [@props.stack.cards.length]
      ]
    ]

  # Utility -----------------------------------------------------------------------

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  makeLinkProps: ->
    url = new WorkspaceUrl(this)
    url.addStack(@props.stack.id)
    return _.extend {key: 'open-link', hotkey: @props.hotkey}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = StackSidebarItem
