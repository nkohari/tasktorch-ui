_            = require 'lodash'
React        = require 'react/addons'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Link         = React.createFactory(Router.Link)
{li, span}   = React.DOM

StackListItem = React.createClass {

  displayName: 'StackListItem'

  mixins: [
    ActiveUrl(WorkspaceUrl)
  ]

  render: ->
    linkProps = _.extend @makeLinkProps(), {key: 'open-link'}
    li {className: 'sidebar-item'}, [
      Link linkProps, [
        Icon {key: 'icon', name: "stack-#{@props.stack.kind.toLowerCase()}"}
        span {key: 'name', className: 'name'}, [@props.stack.name]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return url.makeLinkProps()

}

module.exports = StackListItem
