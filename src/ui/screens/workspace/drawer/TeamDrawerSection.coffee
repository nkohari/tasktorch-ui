_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
StackType       = require 'data/enums/StackType'
CachedState     = require 'ui/framework/mixins/CachedState'
Frame           = React.createFactory(require 'ui/common/Frame')
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
StackDrawerItem = React.createFactory(require 'ui/screens/workspace/drawer/StackDrawerItem')
TeamContextMenu = React.createFactory(require 'ui/screens/workspace/drawer/TeamContextMenu')
{div, span, ul} = React.DOM

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

  isReady: ->
    @state.inboxStack? and @state.backlogStacks?

  render: ->

    inboxStack = StackDrawerItem {key: 'inbox', stack: @state.inboxStack}
    backlogStacks = _.map @state.backlogStacks, (stack) =>
      StackDrawerItem {key: stack.id, stack}

    menu = TeamContextMenu {team: @props.team}

    Frame {@isReady, className: 'drawer-group'},
      div {className: 'header'},
        span {className: 'title'}, @props.team.name
        OverlayTrigger {className: 'settings', overlay: menu},
          Icon {name: 'settings'}
      inboxStack
      backlogStacks

}

module.exports = TeamDrawerSection
