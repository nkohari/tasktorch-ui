#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
StackType   = require 'data/enums/StackType'
CachedState = require 'ui/framework/mixins/CachedState'
Pure        = require 'ui/framework/mixins/Pure'
Icon        = React.createFactory(require 'ui/common/Icon')
{em}        = React.DOM
#--------------------------------------------------------------------------------

StackWidget = React.createClass {

  displayName: 'StackWidget'

  propTypes:
    stack: PropTypes.Stack

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.stack.user) if @props.stack.user?
    team: cache('teams').get(@props.stack.team) if @props.stack.team?
  }

  render: ->

    em {className: 'stack-widget'},
      Icon {name: @props.stack.type.toLowerCase()}
      @formatStackName()

  formatStackName: ->

    if @props.stack.type == StackType.Backlog
      return @props.stack.name

    if @state.team?
      possessive = @state.team.name
    else
      possessive = "#{@state.user.name}'s"

    return "#{possessive} #{@props.stack.type}"

}

module.exports = StackWidget
