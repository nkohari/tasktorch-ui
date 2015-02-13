React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'framework/PropTypes'
Observe            = require 'framework/mixins/Observe'
Url                = require 'framework/Url'
GoalDisplayedEvent = require 'events/display/GoalDisplayedEvent'
Icon               = React.createFactory(require 'ui/common/Icon')
Link               = React.createFactory(require 'ui/common/Link')
ListItem           = React.createFactory(require 'ui/common/ListItem')
{li, a}            = React.DOM

CardGoal = React.createClass {

  displayName: 'CardGoal'

  propTypes:
    goalid: PropTypes.id

  mixins: [
    Observe('goals')
    Router.State
  ]

  componentDidMount: ->
    @publish new GoalDisplayedEvent(@props.goalid)

  componentWillReceiveProps: (newProps) ->
    @publish new GoalDisplayedEvent(newProps.goalid) if newProps.goalid != @props.goalid

  sync: (stores) ->
    {goal: stores.goals.get(@props.goalid)}

  isReady: ->
    @state.goal?

  render: ->

    # TODO: Should link to the specific goal
    url = new Url(this)
    url.screen = 'strategy'

    ListItem {@isReady, className: 'goal'},
      Link url.makeLinkProps(),
        Icon {name: 'goal'}
        @state.goal?.name

}

module.exports = CardGoal
