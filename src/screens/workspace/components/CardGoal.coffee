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

  isReady: ->
    @state.goal?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'goal aspect'}, children

  renderChildren: ->
    return [
      Link @makeLinkProps(), [
        Icon {key: 'icon', name: 'goal'}
        @state.goal.name
      ]
    ]

  # TODO: Should link to the specific goal
  makeLinkProps: ->
    url = @getActiveUrl()
    params = {organizationId: url.organizationId}
    {key: 'icon', to: 'planning', params}

}

module.exports = CardGoal
