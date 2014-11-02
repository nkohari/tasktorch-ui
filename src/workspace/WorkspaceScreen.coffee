_                    = require 'lodash'
React                = require 'react/addons'
Router               = require 'react-router'
Api                  = require '../Api'
Flux                 = require '../mixins/Flux'
ActiveUrl            = require '../mixins/ActiveUrl'
WorkspaceEnvironment = require './WorkspaceEnvironment'
WorkspaceUrl         = require './WorkspaceUrl'
NavigationBar        = React.createFactory(require '../common/NavigationBar')
PresenceBar          = React.createFactory(require '../common/PresenceBar')
PanelGroup           = React.createFactory(require '../common/PanelGroup')
StackPanel           = React.createFactory(require './components/StackPanel')
CardPanel            = React.createFactory(require './components/CardPanel')
WorkspaceSidebar     = React.createFactory(require './components/WorkspaceSidebar')
{div}                = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  mixins: [
    Flux('cards', 'organizations', 'stacks', 'teams', 'types', 'users')
    ActiveUrl(WorkspaceUrl)
    Router.Navigation
  ]

  getDefaultProps: ->
    {controller: WorkspaceEnvironment.createController()}

  getInitialState: ->
    return {
      draggingCard:  undefined
      draggingIndex: undefined
      hoveringCard:  undefined
      hoveringIndex: undefined
    }

  getStateFromStores: (stores) ->
    return {
      currentUser:         stores.users.currentUser
      currentOrganization: stores.organizations.currentOrganization
      stacks:              stores.stacks.stacks
      teams:               stores.teams.teams
    }

  componentWillMount: ->
    window.Screen = this
    controller = @getController()
    controller.setOrganization(@getActiveUrl().organizationId)
    controller.loadWorkspace()
    controller.joinPresenceChannel()

  componentWillUnmount: ->
    controller.leavePresenceChannel()
    window.Screen = undefined

  render: ->

    # TODO: Push this check down into the NavigationBar and PresenceBar?
    unless @state.currentOrganization? and @state.currentUser?
      return div {className: 'workspace screen loading'}, []

    panels = @getActivePanels()
    panels.unshift WorkspaceSidebar {key: 'sidebar', stacks: @state.stacks, teams: @state.teams}

    div {className: 'workspace screen'}, [
      NavigationBar {key: 'navigation-bar', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
      div {key: 'main', className: 'main'}, panels
      PresenceBar {key: 'presence-bar', currentUser: @state.currentUser}
    ]

  getActivePanels: ->
    url = @getActiveUrl()
    position = 0
    stackPanels = _.map url.stacks, (stackId) =>
      StackPanel {key: "stack-#{stackId}", stackId, position: position++}
    cardPanels = _.map url.cards, (cardId) =>
      CardPanel {key: "card-#{cardId}", cardId, position: position++}
    return [
      PanelGroup {key: 'stack-panels'}, stackPanels
      PanelGroup {key: 'card-panels'}, cardPanels
    ]

  startDraggingCard: (draggingCard, draggingIndex) ->
    @setState {draggingCard, draggingIndex}

  stopDraggingCard: ->
    @setState {draggingCard: undefined, draggingIndex: undefined}

  hoveringOver: (hoveringCard, hoveringIndex) ->
    @setState {hoveringCard, hoveringIndex}
}

module.exports = WorkspaceScreen
