_                           = require 'lodash'
React                       = require 'react'
PropTypes                   = require 'common/PropTypes'
TeamStackListDisplayedEvent = require 'events/display/TeamStackListDisplayedEvent'
StackType                   = require 'framework/enums/StackType'
Observe                     = require 'mixins/Observe'
StackSidebarItem            = React.createFactory(require './StackSidebarItem')
{section, header, ul}       = React.DOM

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
    {stacks: stores.stacks.getAllByTeam(@props.team.id)}

  ready: ->
    {stacks: @state.stacks?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    section {className: 'team group'}, @contents()

  children: ->

    inboxStack = StackSidebarItem {key: 'inbox', stack: @getInboxStack()}
    backlogStacks = _.map @getBacklogStacks(), (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    return [
      header {key: 'header'}, [@props.team.name]
      ul {key: 'items'}, [inboxStack].concat(backlogStacks)
    ]

  getInboxStack: ->
    _.find @state.stacks, (stack) -> stack.type == StackType.Inbox

  getBacklogStacks: ->
    stacks = _.filter @state.stacks, (stack) -> stack.type == StackType.Backlog
    _.sortBy stacks, (stack) -> stack.name

  #--------------------------------------------------------------------------------

}

module.exports = TeamStackList
