_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'framework/PropTypes'
StackType    = require 'framework/enums/StackType'
Url          = require 'framework/Url'
Icon         = React.createFactory(require 'ui/common/Icon')
Link         = React.createFactory(require 'ui/common/Link')
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
      Link @makeLinkProps(), [
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
    url = new Url(this)
    url.addStack(@props.stack.id)
    return _.extend {key: 'open-link', hotkey: @props.hotkey}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = StackSidebarItem
