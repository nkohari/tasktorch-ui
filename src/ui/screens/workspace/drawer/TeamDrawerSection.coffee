#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
StackType       = require 'data/enums/StackType'
CachedState     = require 'ui/framework/mixins/CachedState'
DialogTrigger   = React.createFactory(require 'ui/common/DialogTrigger')
DrawerSection   = React.createFactory(require 'ui/common/DrawerSection')
Icon            = React.createFactory(require 'ui/common/Icon')
TeamContextMenu = React.createFactory(require 'ui/overlays/TeamContextMenu')
StackDrawerItem = React.createFactory(require 'ui/screens/workspace/drawer/StackDrawerItem')
{div, span, ul} = React.DOM
#--------------------------------------------------------------------------------

TeamDrawerSection = React.createClass {

  displayName: 'TeamDrawerSection'

  propTypes:
    team: PropTypes.Team

  mixins: [CachedState]

  getCachedState: (cache) ->
    stacks = cache('stacksByTeam').get(@props.team.id)
    if stacks?
      inboxStack = _.find stacks, (stack) -> stack.type == StackType.Inbox
      backlogStacks = _.sortBy _.filter(stacks, (stack) -> stack.type == StackType.Backlog), (stack) -> stack.name
    {inboxStack, backlogStacks}

  render: ->

    if @state.inboxStack?
      inboxStack = StackDrawerItem {key: 'inbox', stack: @state.inboxStack}

    if @state.backlogStacks?
      backlogStacks = _.map @state.backlogStacks, (stack) =>
        StackDrawerItem {key: stack.id, stack}

    controls = DialogTrigger {name: 'CreateStack', teamid: @props.team.id},
      Icon {name: 'add'}

    DrawerSection {className: 'team', title: @props.team.name, controls},
      inboxStack
      backlogStacks

}

module.exports = TeamDrawerSection
