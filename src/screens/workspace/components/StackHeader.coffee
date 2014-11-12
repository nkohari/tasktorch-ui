_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Link         = React.createFactory(Router.Link)
{div, span}  = React.DOM

StackHeader = React.createClass {

  displayName: 'StackHeader'

  mixins: [ActiveUrl(WorkspaceUrl)]

  render: ->
    div {className: 'header'}, [
      Icon {key: 'icon', name: "stack-#{@props.stack.kind?.toLowerCase()}"}
      span {key: 'title', name: 'title'}, [@props.stack.name]
      @makeCloseLink()
    ]

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeStack(@props.stack.id)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

}

module.exports = StackHeader
