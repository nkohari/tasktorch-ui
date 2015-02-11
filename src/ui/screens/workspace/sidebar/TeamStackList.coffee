_                           = require 'lodash'
React                       = require 'react'
PropTypes                   = require 'framework/PropTypes'
TeamStackListDisplayedEvent = require 'events/display/TeamStackListDisplayedEvent'
StackType                   = require 'framework/enums/StackType'
Observe                     = require 'framework/mixins/Observe'
Frame                       = React.createFactory(require 'ui/common/Frame')
List                        = React.createFactory(require 'ui/common/List')
StackSidebarItem            = React.createFactory(require 'ui/screens/workspace/sidebar/StackSidebarItem')
{div}                       = React.DOM

TeamStackList = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'TeamStackList'

  propTypes:
    team: PropTypes.Team

  mixins: [Observe('stacks')]

  # Lifecycle ---------------------------------------------------------------------

  componentDidMount: ->
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

    Frame {@isReady, className: 'team group'},
      div {className: 'header'}, @props.team.name
      List {}, [inboxStack].concat(backlogStacks)

  #--------------------------------------------------------------------------------

}

module.exports = TeamStackList
