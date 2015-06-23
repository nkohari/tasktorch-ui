#--------------------------------------------------------------------------------
_                            = require 'lodash'
React                        = require 'react'
UserAddedCardToGoalEvent     = require 'events/ui/UserAddedCardToGoalEvent'
UserRemovedCardFromGoalEvent = require 'events/ui/UserRemovedCardFromGoalEvent'
PropTypes                    = require 'ui/framework/PropTypes'
Actor                        = require 'ui/framework/mixins/Actor'
CachedState                  = require 'ui/framework/mixins/CachedState'
Avatar                       = React.createFactory(require 'ui/common/Avatar')
Checkbox                     = React.createFactory(require 'ui/common/Checkbox')
DialogTrigger                = React.createFactory(require 'ui/common/DialogTrigger')
Overlay                      = React.createFactory(require 'ui/common/Overlay')
{div, ul, li}                = React.DOM
#--------------------------------------------------------------------------------
require './CardGoalsOverlay.styl'
#--------------------------------------------------------------------------------

CardGoalsOverlay = React.createClass {

  displayName: 'CardGoalsOverlay'

  propTypes:
    card:        PropTypes.Card
    hideOverlay: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    {allGoals: cache('goalsByOrg').get(@props.card.org)}

  componentWillMount: ->
    @setState {selectedGoals: @props.card.goals}

  componentWillReceiveProps: (newProps) ->
    @setState {selectedGoals: newProps.card.goals}

  render: ->

    if @state.allGoals?
      goals = _.map @state.allGoals, (goal) =>
        checked = _.contains(@state.selectedGoals, goal.id)
        li {className: 'goal'},
          Checkbox {checked, text: goal.name, onChange: @onGoalToggled.bind(this, goal)}

    Overlay {className: 'card-goals-overlay', arrow: true, hideOverlay: @props.hideOverlay},
      div {className: 'content'},
        ul {className: 'goal-list'}, goals
      div {className: 'buttons'},
        DialogTrigger {name: 'CreateGoal', cardid: @props.card.id, onClick: @onCreateGoalClicked},
          'Create another goal...'

  onCreateGoalClicked: ->
    @props.hideOverlay()

  onGoalToggled: (goal, event) ->
    if (event.target.checked)
      @setState {selectedGoals: @state.selectedGoals.concat([goal.id])}
      @publish new UserAddedCardToGoalEvent(goal.id, @props.card.id)
    else
      @setState {selectedGoals: _.without(@state.selectedGoals, goal.id)}
      @publish new UserRemovedCardFromGoalEvent(goal.id, @props.card.id)

}

module.exports = CardGoalsOverlay
