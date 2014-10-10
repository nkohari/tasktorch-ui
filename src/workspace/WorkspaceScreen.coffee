_                  = require 'lodash'
React              = require 'react/addons'
Router             = require 'react-router'
Api                = require '../Api'
NavigationBar      = require '../common/NavigationBar'
PanelGroup         = require '../common/PanelGroup'
WorkspaceSidebar   = require './WorkspaceSidebar'
WorkspaceViewState = require './WorkspaceViewState'
StackPanel         = require './StackPanel'
CardPanel          = require './CardPanel'
{div}              = React.DOM

WorkspaceScreen = React.createClass {

  mixins: [Router.ActiveState, Router.Navigation],

  getInitialState: ->
    return {
      user:         undefined
      organization: undefined
      types:        []
      teams:        []
      stacks:       {inbox: undefined, queue: undefined, backlog: []}
      activeItems:  {stacks: [], cards: []}
      draggingCard: undefined
    }

  componentWillMount: ->
    window.Screen = this
    {organizationId} = @getActiveParams()
    Api.getMyWorkspace organizationId, (res) =>
      return @transitionTo('login') if res.unauthorized
      {user, organization, types, teams, stacks} = res.body
      @setState {user, organization, types, teams, stacks}

  componentWillUnmount: ->
    window.Screen = undefined

  render: ->

    unless @state.organization?
      return div {className: 'workspace screen loading'}, []

    div {className: 'workspace screen'}, [
      NavigationBar {organization: @state.organization, user: @state.user}
      div {className: 'main'}, [
        WorkspaceSidebar {stacks: @state.stacks, teams: @state.teams}
        PanelGroup {}, @getActivePanels()
      ]
    ]

  getActivePanels: ->
    viewState = new WorkspaceViewState(this)
    position = 0
    stackPanels = _.map viewState.stacks, (stackId) =>
      StackPanel {stackId, key: "stack-#{stackId}", position: position++}
    cardPanels = _.map viewState.cards, (cardId) =>
      CardPanel {cardId, key: "card-#{cardId}", position: position++}
    return stackPanels.concat(cardPanels)

  startDraggingCard: (card) ->
    @setState {draggingCard: card}

  stopDraggingCard: ->
    @setState {draggingCard: undefined}

}

module.exports = WorkspaceScreen
