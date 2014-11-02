_            = require 'lodash'
React        = require 'react/addons'
Router       = require 'react-router'
ActiveUrl    = require '../../mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
Icon         = React.createFactory(require '../../common/Icon')
Link         = React.createFactory(Router.Link)
{li, span}   = React.DOM

StackListItem = React.createClass {

  displayName: 'StackListItem'

  mixins: [
    ActiveUrl(WorkspaceUrl)
  ]

  render: ->
    linkProps = _.extend @makeLinkProps(), {key: 'open-stack-link'}
    li {className: 'stack-list-item'}, [
      Link linkProps, [
        Icon {key: 'stack-icon', name: "stack-#{@props.stack.kind}"}
        span {key: 'stack-name', className: 'stack-name'}, [@props.stack.name]
        span {key: 'stack-card-count', className: 'stack-card-count'}, [@props.stack.cards.length]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return url.makeLinkProps()

}

module.exports = StackListItem
