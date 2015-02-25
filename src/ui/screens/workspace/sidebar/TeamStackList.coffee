_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
StackType        = require 'data/enums/StackType'
CachedState      = require 'ui/framework/mixins/CachedState'
Frame            = React.createFactory(require 'ui/common/Frame')
List             = React.createFactory(require 'ui/common/List')
StackSidebarItem = React.createFactory(require 'ui/screens/workspace/sidebar/StackSidebarItem')

TeamStackList = React.createClass {

  displayName: 'TeamStackList'

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

    inboxStack = StackSidebarItem {key: 'inbox', stack: @state.inboxStack}
    backlogStacks = _.map @state.backlogStacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    Frame {@isReady, className: 'team group'},
      Frame {className: 'header'}, @props.team.name
      List {}, [inboxStack].concat(backlogStacks)

}

module.exports = TeamStackList
