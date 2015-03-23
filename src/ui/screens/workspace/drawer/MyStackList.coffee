_               = require 'lodash'
React           = require 'react'
StackType       = require 'data/enums/StackType'
Frame           = React.createFactory(require 'ui/common/Frame')
List            = React.createFactory(require 'ui/common/List')
StackDrawerItem = React.createFactory(require 'ui/screens/workspace/drawer/StackDrawerItem')
{div}           = React.DOM

MyStackList = React.createClass {

  displayName: 'MyStackList'

  render: ->

    Frame {className: 'me group'},
      div {className: 'header'}, 'My Stacks'
      List {}, @renderItems()

  renderItems: ->

    queue  = @getSpecialStack(StackType.Queue)
    inbox  = @getSpecialStack(StackType.Inbox)
    drafts = @getSpecialStack(StackType.Drafts)

    return [] unless queue? and inbox? and drafts?

    specialStacks = [
      StackDrawerItem {key: 'inbox',  stack: inbox}
      StackDrawerItem {key: 'queue',  stack: queue}
      StackDrawerItem {key: 'drafts', stack: drafts}
    ]

    backlogStacks = _.map @getBacklogStacks(), (stack) =>
      StackDrawerItem {key: "stack-#{stack.id}", stack}

    return specialStacks.concat(backlogStacks)

  getSpecialStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

  getBacklogStacks: ->
    stacks = _.filter @props.stacks, (stack) -> stack.type == StackType.Backlog
    _.sortBy stacks, (stack) -> stack.name

}

module.exports = MyStackList
