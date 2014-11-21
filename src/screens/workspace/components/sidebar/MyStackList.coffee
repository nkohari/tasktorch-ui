_                = require 'lodash'
React            = require 'react'
Observe          = require 'mixins/Observe'
StackType        = require 'framework/enums/StackType'
StackSidebarItem = React.createFactory(require './StackSidebarItem')
{div, ul}        = React.DOM

MyStackList = React.createClass {

  displayName: 'MyStackList'

  render: ->

    inbox = @getStack(StackType.Inbox)
    queue = @getStack(StackType.Queue)

    children = []
    if inbox? and queue?
      children = [
        StackSidebarItem {key: 'inbox', stack: inbox, hotkey: 'i'}
        StackSidebarItem {key: 'queue', stack: queue, hotkey: 'q'}
      ]

    div {className: 'me group'}, [
      div {key: 'header', className: 'header'}, ['My Work']
      ul {key: 'items'}, children
    ]

  getStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

}

module.exports = MyStackList
