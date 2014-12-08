_                = require 'lodash'
React            = require 'react'
Router           = require 'react-router'
ActiveUrl        = require 'mixins/ActiveUrl'
Observe          = require 'mixins/Observe'
WorkspaceUrl     = require '../../WorkspaceUrl'
LoadStackRequest = require 'requests/LoadStackRequest'
Icon             = React.createFactory(require 'common/Icon')
StackHeader      = React.createFactory(require './StackHeader')
StackCardList    = React.createFactory(require './StackCardList')
StackFooter      = React.createFactory(require './StackFooter')
Link             = React.createFactory(Router.Link)
{div}            = React.DOM

StackPanel = React.createClass {

  displayName: 'StackPanel'

  mixins: [
    Observe('stacks')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    stackId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    {stack: stores.stacks.getStack(@props.stackId)}

  componentWillReceiveProps: (newProps) ->
    @loadStack(newProps.stackId) if @props.stackId != newProps.stackId

  componentWillMount: ->
    @loadStack(@props.stackId)

  loadStack: (stackId) ->
    @execute new LoadStackRequest(stackId)

  isReady: ->
    @state.stack?

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    div {
      className: 'stack panel'
      style:     {zIndex: 99 - @props.position}
    }, @getChildren()

  renderChildren: ->
    return [
      @makeCloseLink()
      StackHeader {key: 'header', stack: @state.stack}
      StackCardList {key: 'cards', stack: @state.stack}
      StackFooter {key: 'footer', stack: @state.stack}
    ]

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeStack(@props.stackId)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

}

module.exports = StackPanel
