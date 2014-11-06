React        = require 'react'
Flux         = require '../../mixins/Flux'
List         = React.createFactory(require '../../common/List')
GoalListItem = React.createFactory(require './GoalListItem')
{div}        = React.DOM

PlanningSidebar = React.createClass {

  displayName: 'PlanningSidebar'

  mixins: [Flux('goals')]

  getStateFromStores: (stores) ->
    return {
      goals: stores.goals.getAllGoals()
    }

  componentWillMount: ->
    @getController().loadGoals()

  render: ->
    div {className: 'planning sidebar'}, [
      List {key: 'goal-list', className: 'goal-list', component: GoalListItem, kind: 'goal', items: @state.goals}
    ]

}

module.exports = PlanningSidebar
