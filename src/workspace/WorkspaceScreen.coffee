_                    = require 'lodash'
React                = require 'react/addons'
Router               = require 'react-router'
Api                  = require '../Api'
Flux                 = require '../mixins/Flux'
ActiveUrl            = require '../mixins/ActiveUrl'
WorkspaceEnvironment = require './WorkspaceEnvironment'
WorkspaceUrl         = require './WorkspaceUrl'
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
    controller.joinOrganizationChannel()

  componentWillUnmount: ->
    @getController().leaveOrganizationChannel()
    window.Screen = undefined

  render: ->

    # TODO: Push this check down into the ScreenHeader and PresenceBar?
    unless @state.currentOrganization? and @state.currentUser?
      return div {className: 'workspace screen loading'}, []

    url = @getActiveUrl()
    position = 0
    stackPanels = _.map url.stacks, (stackId) =>
      StackPanel {key: "stack-#{stackId}", stackId, position: position++}
    cardPanels = _.map url.cards, (cardId) =>
      CardPanel {key: "card-#{cardId}", cardId, position: position++}

    div {className: 'workspace screen'}, [
      WorkspaceSidebar {key: 'sidebar', stacks: @state.stacks, teams: @state.teams}
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
