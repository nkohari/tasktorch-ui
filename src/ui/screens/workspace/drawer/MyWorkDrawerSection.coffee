#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
StackType         = require 'data/enums/StackType'
DrawerSection     = React.createFactory(require 'ui/common/DrawerSection')
MyWorkContextMenu = React.createFactory(require 'ui/overlays/MyWorkContextMenu')
StackDrawerItem   = React.createFactory(require 'ui/screens/workspace/drawer/StackDrawerItem')
{div, span, ul}   = React.DOM
#--------------------------------------------------------------------------------

MyWorkDrawerSection = React.createClass {

  displayName: 'MyWorkDrawerSection'

  render: ->

    DrawerSection {className: 'my-work', title: 'My Stacks', menu: MyWorkContextMenu {}},
      @renderItems()

  renderItems: ->

    queue  = @getSpecialStack(StackType.Queue)
    inbox  = @getSpecialStack(StackType.Inbox)

    return [] unless queue? and inbox?

    specialStacks = [
      StackDrawerItem {key: 'inbox',  stack: inbox}
      StackDrawerItem {key: 'queue',  stack: queue}
    ]

    backlogStacks = _.map @getBacklogStacks(), (stack) =>
      StackDrawerItem {key: stack.id, stack}

    return specialStacks.concat(backlogStacks)

  getSpecialStack: (type) ->
    _.find @props.stacks, (stack) -> stack.type == type

  getBacklogStacks: ->
    stacks = _.filter @props.stacks, (stack) -> stack.type == StackType.Backlog
    _.sortBy stacks, (stack) -> stack.name

}

module.exports = MyWorkDrawerSection
