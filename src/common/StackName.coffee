_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'common/PropTypes'
TeamDisplayedEvent = require 'events/display/TeamDisplayedEvent'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
StackType          = require 'framework/enums/StackType'
Observe            = require 'mixins/Observe'
{span}             = React.DOM

StackName = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackName'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Observe('teams', 'users')]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.stack.owner) if @props.stack.owner?
    @publish new TeamDisplayedEvent(@props.stack.team)  if @props.stack.team?

  componentWillReceiveProps: (newProps) ->
    prev = @props.stack
    curr = newProps.stack
    @publish new UserDisplayedEvent(curr.owner) if curr.owner? and curr.owner != prev.owner
    @publish new TeamDisplayedEvent(curr.team)  if curr.team?  and curr.team  != prev.team

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      owner:       stores.users.get(@props.stack.owner) if @props.stack.owner?
      team:        stores.teams.get(@props.stack.team)  if @props.stack.team?
    }

  ready: ->
    return {
      currentUser: @state.currentUser?
      owner:       (@state.owner? or not @props.stack.owner?)
      team:        (@state.team? or not @props.stack.team?)
    }

  # Rendering ---------------------------------------------------------------------

  render: ->
    span @props, @renderChildrenIfReady()

  children: ->

    if @props.stack.type == StackType.Backlog
      return @props.stack.name

    if @state.team?
      possessive = @state.team.name
    else
      if @state.owner.id == @state.currentUser.id
        possessive = 'My'
      else
        possessive = "#{@state.owner.name}'s"

    return "#{possessive} #{@props.stack.type}"

  #--------------------------------------------------------------------------------

}

module.exports = StackName
