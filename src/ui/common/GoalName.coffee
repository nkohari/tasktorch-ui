#--------------------------------------------------------------------------------
React        = require 'react'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Pure         = require 'ui/framework/mixins/Pure'
Icon         = React.createFactory(require 'ui/common/Icon')
{div}        = React.DOM
#--------------------------------------------------------------------------------

GoalName = React.createClass {

  displayName: 'GoalName'

  propTypes:
    goalid: PropTypes.id

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  render: ->

    # TODO: Link to the goal on the strategy screen?

    classes = mergeClasses('goal', @props.className)
    div {className: classes},
      Icon {name: 'goal'}
      @state.goal?.name

}

module.exports = GoalName
