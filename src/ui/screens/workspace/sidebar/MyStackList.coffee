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

    specialStacks = [
      StackSidebarItem {key: 'queue',  stack: @getSpecialStack(StackType.Queue),  hotkey: 'q'}
      StackSidebarItem {key: 'inbox',  stack: @getSpecialStack(StackType.Inbox),  hotkey: 'i'} 
      StackSidebarItem {key: 'drafts', stack: @getSpecialStack(StackType.Drafts), hotkey: 'd'}
    ]

    backlogStacks = _.map @getBacklogStacks(), (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    Frame {className: 'me group'},
      div {className: 'header'}, 'My Work'
      List {}, specialStacks.concat(backlogStacks)

  getSpecialStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

  getBacklogStacks: ->
    stacks = _.filter @props.stacks, (stack) -> stack.type == StackType.Backlog
    _.sortBy stacks, (stack) -> stack.name

}

module.exports = MyStackList
