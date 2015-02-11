React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'framework/PropTypes'
Observe            = require 'framework/mixins/Observe'
WorkspaceUrl       = require 'framework/urls/WorkspaceUrl'
GoalDisplayedEvent = require 'events/display/GoalDisplayedEvent'
Icon               = React.createFactory(require 'ui/common/Icon')
Link               = React.createFactory(require 'ui/common/Link')
ListItem           = React.createFactory(require 'ui/common/ListItem')
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

  componentDidMount: ->
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
    ListItem {@isReady, className: 'goal'}, [
      Link @makeLinkProps(), [
        Icon {key: 'icon', name: 'goal'}
        @state.goal?.name
      ]
    ]

  # Utility -----------------------------------------------------------------------

  makeLinkProps: ->
    # TODO: Should link to the specific goal
    url = new WorkspaceUrl(this)
    params = {orgid: url.orgid}
    {key: 'icon', to: 'strategy', params}

  #--------------------------------------------------------------------------------

}

module.exports = CardGoal
