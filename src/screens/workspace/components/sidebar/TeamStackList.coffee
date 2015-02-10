_                           = require 'lodash'
React                       = require 'react'
PropTypes                   = require 'common/PropTypes'
TeamStackListDisplayedEvent = require 'events/display/TeamStackListDisplayedEvent'
StackType                   = require 'framework/enums/StackType'
Observe                     = require 'mixins/Observe'
Frame                       = React.createFactory(require 'common/Frame')
StackSidebarItem            = React.createFactory(require './StackSidebarItem')
{header, ul}                = React.DOM

TeamStackList = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'TeamStackList'

  propTypes:
    team: PropTypes.Team

  mixins: [Observe('stacks')]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new TeamStackListDisplayedEvent(@props.team.id)

  componentWillReceiveProps: (newProps) ->
    unless @props.team.id == newProps.team.id
      @publish new TeamStackListDisplayedEvent(@props.team.id)

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    stacks = stores.stacks.getAllByTeam(@props.team.id)
    if stacks?
      inboxStack = _.find stacks, (stack) -> stack.type == StackType.Inbox
      backlogStacks = _.sortBy _.filter(stacks, (stack) -> stack.type == StackType.Backlog), (stack) -> stack.name
    {inboxStack, backlogStacks}

  isReady: ->
    @state.inboxStack? and @state.backlogStacks?

  # Rendering ---------------------------------------------------------------------

  render: ->

    inboxStack = StackSidebarItem {key: 'inbox', stack: @state.inboxStack}
    backlogStacks = _.map @state.backlogStacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    Frame {@isReady, component: 'section', className: 'team group'}, [
      header {key: 'header'}, [@props.team.name]
      ul {key: 'items'}, [inboxStack].concat(backlogStacks)
    ]

  #--------------------------------------------------------------------------------

}

module.exports = TeamStackList
