_                = require 'lodash'
React            = require 'react'
Observe          = require 'mixins/Observe'
StackType        = require 'framework/enums/StackType'
StackSidebarItem = React.createFactory(require './StackSidebarItem')
{section, header, ul} = React.DOM

MyStackList = React.createClass {

  displayName: 'MyStackList'

  render: ->

    queue  = @getStack(StackType.Queue)
    inbox  = @getStack(StackType.Inbox)
    drafts = @getStack(StackType.Drafts)

    children = []
    if inbox? and queue?
      children = [
        StackSidebarItem {key: 'queue',  stack: queue, hotkey: 'q'}
        StackSidebarItem {key: 'inbox',  stack: inbox, hotkey: 'i'} 
        StackSidebarItem {key: 'drafts', stack: drafts, hotkey: 'd'}
      ]

    section {className: 'me group'}, [
      header {key: 'header'}, ['My Work']
      ul {key: 'items'}, children
    ]

  getStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

}

module.exports = MyStackList
