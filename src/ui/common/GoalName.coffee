React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Pure        = require 'ui/framework/mixins/Pure'
Icon        = React.createFactory(require 'ui/common/Icon')
{div}       = React.DOM

CardGoal = React.createClass {

  displayName: 'CardGoal'

  propTypes:
    goalid: PropTypes.id

  mixins: [CachedState, Pure]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  render: ->

    # TODO: Link to the goal on the strategy screen

    div {className: 'goal'},
      Icon {name: 'goal'}
      @state.goal?.name

}

module.exports = CardGoal
