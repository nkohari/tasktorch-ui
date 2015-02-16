React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'framework/PropTypes'
Observe            = require 'framework/mixins/Observe'
Url                = require 'framework/Url'
GoalDisplayedEvent = require 'events/display/GoalDisplayedEvent'
Icon               = React.createFactory(require 'ui/common/Icon')
Frame              = React.createFactory(require 'ui/common/Frame')
Link               = React.createFactory(require 'ui/common/Link')

CardGoal = React.createClass {

  displayName: 'CardGoal'

  propTypes:
    goalid: PropTypes.id

  mixins: [
    Observe('goals')
    Router.State
  ]

  getDefaultProps: ->
    {link: false}

  componentDidMount: ->
    @publish new GoalDisplayedEvent(@props.goalid)

  componentWillReceiveProps: (newProps) ->
    @publish new GoalDisplayedEvent(newProps.goalid) if newProps.goalid != @props.goalid

  sync: (stores) ->
    {goal: stores.goals.get(@props.goalid)}

  isReady: ->
    @state.goal?

  render: ->

    # TODO: Link to the goal on the strategy screen

    Frame {@isReady, className: 'goal'},
      Icon {name: 'goal'}
      @state.goal?.name

}

module.exports = CardGoal
