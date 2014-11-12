_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadAllGoalsRequest = require 'requests/LoadAllGoalsRequest'
SidebarItemGroup    = React.createFactory(require 'common/SidebarItemGroup')
GoalSidebarItem     = React.createFactory(require './GoalSidebarItem')
{div}               = React.DOM

PlanningSidebar = React.createClass {

  displayName: 'PlanningSidebar'

  mixins: [Observe('goals')]

  getStateFromStores: (stores) ->
    return {
      goals: stores.goals.getAllGoals()
    }

  componentWillMount: ->
    @execute new LoadAllGoalsRequest()

  render: ->

    goals = _.map @state.goals, (goal) =>
      GoalSidebarItem {key: "goal-#{goal.id}", goal}

    div {className: 'planning sidebar panel'}, [
      SidebarItemGroup {key: 'goals', header: "Goals"}, goals
    ]

}

module.exports = PlanningSidebar
