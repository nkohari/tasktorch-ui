_            = require 'lodash'
keymaster    = require 'keymaster'
React        = require 'react/addons'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Hotlink      = React.createFactory(require 'common/Hotlink')
{li, span}   = React.DOM

StackSidebarItem = React.createClass {

  displayName: 'StackSidebarItem'

  mixins: [
    ActiveUrl(WorkspaceUrl)
  ]

  render: ->
    linkProps = _.extend @makeLinkProps(), {key: 'open-link', hotkey: @props.hotkey}
    li {className: 'sidebar-item'}, [
      Hotlink linkProps, [
        Icon {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
        span {key: 'name', className: 'name'}, [@props.stack.name]
        span {key: 'count', className: 'count'}, [@props.stack.cards.length]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return url.makeLinkProps()

}

module.exports = StackSidebarItem
