_                = require 'lodash'
React            = require 'react'
Observe          = require 'framework/mixins/Observe'
StackType        = require 'framework/enums/StackType'
Frame            = React.createFactory(require 'ui/common/Frame')
List             = React.createFactory(require 'ui/common/List')
StackSidebarItem = React.createFactory(require 'ui/screens/workspace/sidebar/StackSidebarItem')
{div}            = React.DOM

MyStackList = React.createClass {

  displayName: 'MyStackList'

  render: ->

    Frame {className: 'me group'},
      div {className: 'header'}, 'My Work'
      List {}, @renderItems()

  renderItems: ->

    queue  = @getSpecialStack(StackType.Queue)
    inbox  = @getSpecialStack(StackType.Inbox)
    drafts = @getSpecialStack(StackType.Drafts)

    return [] unless queue? and inbox? and drafts?

    specialStacks = [
      StackSidebarItem {key: 'queue',  stack: queue,  hotkey: 'q'}
      StackSidebarItem {key: 'inbox',  stack: inbox,  hotkey: 'i'} 
      StackSidebarItem {key: 'drafts', stack: drafts, hotkey: 'd'}
    ]

    backlogStacks = _.map @getBacklogStacks(), (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    return specialStacks.concat(backlogStacks)

  getSpecialStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

  getBacklogStacks: ->
    stacks = _.filter @props.stacks, (stack) -> stack.type == StackType.Backlog
    _.sortBy stacks, (stack) -> stack.name

}

module.exports = MyStackList
