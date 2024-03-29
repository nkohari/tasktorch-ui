#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
mergeProps      = require 'common/util/mergeProps'
StackType       = require 'data/enums/StackType'
CachedState     = require 'ui/framework/mixins/CachedState'
Pure            = require 'ui/framework/mixins/Pure'
IdentityContext = require 'ui/framework/mixins/IdentityContext'
{span}          = React.DOM
#--------------------------------------------------------------------------------

StackName = React.createClass {

  displayName: 'StackName'

  propTypes:
    stack: PropTypes.Stack

  mixins: [CachedState, Pure, IdentityContext]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.stack.user) if @props.stack?.user?
    team: cache('teams').get(@props.stack.team) if @props.stack?.team?
  }

  render: ->

    span @props,
      @formatStackName() if @props.stack? and @state.user? or @state.team?

  formatStackName: ->

    if @props.stack.type == StackType.Backlog
      return @props.stack.name

    if @state.team?
      possessive = @state.team.name
    else
      if @state.user.id == @getCurrentUser().id
        possessive = 'My'
      else
        possessive = "#{@state.user.name}'s"

    if @props.stack.type == StackType.Queue
      return "#{possessive} Priorities"
    else
      return "#{possessive} #{@props.stack.type}"

}

module.exports = StackName
