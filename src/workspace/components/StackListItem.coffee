_            = require 'lodash'
React        = require 'react/addons'
Router       = require 'react-router'
Icon         = require '../../common/Icon'
ActiveUrl    = require '../../mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
{li, span}   = React.DOM
{Link}       = Router

StackListItem = React.createClass {

  mixins: [
    ActiveUrl(WorkspaceUrl)
  ]

  render: ->
    li {className: 'stack-list-item'}, [
      Link @makeLinkProps(), [
        Icon {name: "stack-#{@props.stack.kind}"}
        span {className: 'stack-name'}, [@props.stack.name]
        span {className: 'stack-card-count'}, [@props.stack.cards.length]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return url.makeLinkProps()

}

module.exports = StackListItem
