_                           = require 'lodash'
React                       = require 'react'
PropTypes                   = require 'common/PropTypes'
TeamStackListDisplayedEvent = require 'events/display/TeamStackListDisplayedEvent'
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
    @publish new TeamStackListDisplayedEvent(@props.team.id, @props.team.stacks)

  componentWillReceiveProps: (newProps) ->
    prev = @props.team
    curr = newProps.team
    unless _.isEqual(prev.stacks, curr.stacks)
      @publish new TeamStackListDisplayedEvent(@props.team.id, @props.team.stacks)

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    {stacks: stores.stacks.getAllByTeam(@props.team.id)}

  ready: ->
    {stacks: @state.stacks?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    section {className: 'team group'}, @contents()

  children: ->

    stacks = _.map @state.stacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    return [
      header {key: 'header'}, [@props.team.name]
      ul {key: 'items'}, stacks
    ]

  #--------------------------------------------------------------------------------

}

module.exports = TeamStackList
