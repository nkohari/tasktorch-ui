React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Pure        = require 'ui/framework/mixins/Pure'
Icon        = React.createFactory(require 'ui/common/Icon')
Frame       = React.createFactory(require 'ui/common/Frame')

CardGoal = React.createClass {

  displayName: 'CardGoal'

  propTypes:
    goalid: PropTypes.id

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  isReady: ->
    @state.goal?

  render: ->

    # TODO: Link to the goal on the strategy screen

    Frame {@isReady, className: 'goal'},
      Icon {name: 'goal'}
      @state.goal?.name

}

module.exports = CardGoal
