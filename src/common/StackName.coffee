_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'common/PropTypes'
mergeProps         = require 'common/util/mergeProps'
TeamDisplayedEvent = require 'events/display/TeamDisplayedEvent'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
StackType          = require 'framework/enums/StackType'
Observe            = require 'mixins/Observe'
Frame              = React.createFactory(require 'common/Frame')
{span}             = React.DOM

StackName = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackName'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Observe('teams', 'users')]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.stack.user) if @props.stack.user?
    @publish new TeamDisplayedEvent(@props.stack.team) if @props.stack.team?

  componentWillReceiveProps: (newProps) ->
    prev = @props.stack
    curr = newProps.stack
    @publish new UserDisplayedEvent(curr.user) if curr.user? and curr.user != prev.user
    @publish new TeamDisplayedEvent(curr.team) if curr.team? and curr.team  != prev.team

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      user:        stores.users.get(@props.stack.user) if @props.stack.user?
      team:        stores.teams.get(@props.stack.team) if @props.stack.team?
    }

  isReady: ->
    @state.currentUser? and (@state.user? or @state.team?)

  # Rendering ---------------------------------------------------------------------

  render: ->
    props = mergeProps @props, {@isReady, component: 'span'}
    Frame props, [@formatStackName()]

  formatStackName: ->
    return unless @isReady()

    if @props.stack.type == StackType.Backlog
      return @props.stack.name

    if @state.team?
      possessive = @state.team.name
    else
      if @state.user.id == @state.currentUser.id
        possessive = 'My'
      else
        possessive = "#{@state.user.name}'s"

    return "#{possessive} #{@props.stack.type}"

  #--------------------------------------------------------------------------------

}

module.exports = StackName
