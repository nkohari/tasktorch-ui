_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'common/PropTypes'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Hotlink      = React.createFactory(require 'common/Hotlink')
{li, span}   = React.DOM

StackSidebarItem = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackSidebarItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [ActiveUrl(WorkspaceUrl)]

  # Rendering ---------------------------------------------------------------------

  render: ->
    li {className: 'sidebar-item'}, [
      Hotlink @makeLinkProps(), [
        Icon {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
        span {key: 'name', className: 'name'}, [@props.stack.name]
        span {key: 'count', className: 'count'}, [@props.stack.cards.length]
      ]
    ]

  # Utility -----------------------------------------------------------------------

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return _.extend {key: 'open-link', hotkey: @props.hotkey}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = StackSidebarItem
