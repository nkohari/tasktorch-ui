React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'common/PropTypes'
ActiveUrl          = require 'mixins/ActiveUrl'
Observe            = require 'mixins/Observe'
WorkspaceUrl       = require '../../WorkspaceUrl'
GoalDisplayedEvent = require 'events/display/GoalDisplayedEvent'
Icon               = React.createFactory(require 'common/Icon')
Link               = React.createFactory(Router.Link)
{li, a}            = React.DOM

CardGoal = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardGoal'

  propTypes:
    goalId: PropTypes.id

  mixins: [
    Observe('goals')
    ActiveUrl(WorkspaceUrl)
  ]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new GoalDisplayedEvent(@props.goalId)

  componentWillReceiveProps: (newProps) ->
    @publish new GoalDisplayedEvent(newProps.goalId) if newProps.goalId != @props.goalId

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    {goal: stores.goals.get(@props.goalId)}

  ready: ->
    {goal: @state.goal?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    li {className: 'goal'}, @contents()

  children: ->
    return [
      Link @makeLinkProps(), [
        Icon {key: 'icon', name: 'goal'}
        @state.goal.name
      ]
    ]

  # Utility -----------------------------------------------------------------------

  makeLinkProps: ->
    # TODO: Should link to the specific goal
    url = @getActiveUrl()
    params = {orgId: url.orgId}
    {key: 'icon', to: 'planning', params}

  #--------------------------------------------------------------------------------

}

module.exports = CardGoal
