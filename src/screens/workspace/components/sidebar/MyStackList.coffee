_                = require 'lodash'
React            = require 'react'
Observe          = require 'mixins/Observe'
StackType        = require 'framework/enums/StackType'
StackSidebarItem = React.createFactory(require './StackSidebarItem')
{div, ul}        = React.DOM

MyStackList = React.createClass {

  displayName: 'MyStackList'

  render: ->

    inbox = _.find @props.stacks, (stack) -> stack.type == StackType.Inbox
    queue = _.find @props.stacks, (stack) -> stack.type == StackType.Queue

    console.log {stacks: @props.stacks, inbox, queue}

    children = []
    if inbox? and queue?
      children = [
        StackSidebarItem {key: 'inbox', stack: inbox}
        StackSidebarItem {key: 'queue', stack: queue}
      ]

    div {className: 'me group'}, [
      div {key: 'header', className: 'header'}, ['My Work']
      ul {key: 'items'}, children
    ]

}

module.exports = MyStackList
