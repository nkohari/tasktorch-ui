React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'common/PropTypes'
Observe            = require 'mixins/Observe'
WorkspaceUrl       = require 'framework/urls/WorkspaceUrl'
GoalDisplayedEvent = require 'events/display/GoalDisplayedEvent'
Frame              = React.createFactory(require 'common/Frame')
Icon               = React.createFactory(require 'common/Icon')
Link               = React.createFactory(Router.Link)
{li, a}            = React.DOM

CardGoal = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardGoal'

  propTypes:
    goalid: PropTypes.id

  mixins: [
    Observe('goals')
    Router.State
  ]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new GoalDisplayedEvent(@props.goalid)

  componentWillReceiveProps: (newProps) ->
    @publish new GoalDisplayedEvent(newProps.goalid) if newProps.goalid != @props.goalid

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    {goal: stores.goals.get(@props.goalid)}

  isReady: ->
    @state.goal?

  # Rendering ---------------------------------------------------------------------

  render: ->
    Frame {@isReady, component: 'li', className: 'goal'}, [
      Link @makeLinkProps(), [
        Icon {key: 'icon', name: 'goal'}
        @state.goal.name
      ]
    ]

  # Utility -----------------------------------------------------------------------

  makeLinkProps: ->
    # TODO: Should link to the specific goal
    url = new WorkspaceUrl(this)
    params = {orgid: url.orgid}
    {key: 'icon', to: 'planning', params}

  #--------------------------------------------------------------------------------

}

module.exports = CardGoal
