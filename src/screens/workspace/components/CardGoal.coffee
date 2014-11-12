React           = require 'react'
Router          = require 'react-router'
ActiveUrl       = require 'mixins/ActiveUrl'
Observe         = require 'mixins/Observe'
WorkspaceUrl    = require '../WorkspaceUrl'
LoadGoalRequest = require 'requests/LoadGoalRequest'
Icon            = React.createFactory(require 'common/Icon')
Link            = React.createFactory(Router.Link)
{div, a}        = React.DOM

CardGoal = React.createClass {

  displayName: 'CardGoal'

  mixins: [
    Observe('goals')
    ActiveUrl(WorkspaceUrl)
  ]

  getStateFromStores: (stores) ->
    {goal: stores.goals.getGoal(@props.goalId)}

  componentWillMount: ->
    @execute new LoadGoalRequest(@props.goalId)

  render: ->

    unless @state.goal?
      return div {className: 'goal aspect loading'}, []

    div {className: 'goal aspect'}, [
      div {key: 'name', className: 'name'}, ['Goal']
      div {key: 'value', className: 'value'}, [
        Link @makeLinkProps(), [
          Icon {key: 'icon', name: 'goal'}
          @state.goal.name
        ]
      ]
    ]

  # TODO: Should link to the specific goal
  makeLinkProps: ->
    url = @getActiveUrl()
    params = {organizationId: url.organizationId}
    {key: 'icon', to: 'planning', params}

}

module.exports = CardGoal
