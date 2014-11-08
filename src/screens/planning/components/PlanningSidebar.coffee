_                = require 'lodash'
React            = require 'react'
Flux             = require 'mixins/Flux'
SidebarItemGroup = React.createFactory(require 'common/SidebarItemGroup')
GoalSidebarItem  = React.createFactory(require './GoalSidebarItem')
{div}            = React.DOM

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

    goals = _.map @state.goals, (goal) =>
      GoalSidebarItem {key: "goal-#{goal.id}", goal}

    div {className: 'planning sidebar'}, [
      SidebarItemGroup {key: 'goals', header: "Goals"}, goals
    ]

}

module.exports = PlanningSidebar
