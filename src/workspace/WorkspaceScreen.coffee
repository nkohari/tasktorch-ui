_                   = require 'lodash'
React               = require 'react/addons'
Router              = require 'react-router'
Api                 = require '../Api'
NavigationBar       = require '../common/NavigationBar'
PresenceBar         = require '../common/PresenceBar'
PanelGroup          = require '../common/PanelGroup'
Flux                = require '../mixins/Flux'
ActiveUrl           = require '../mixins/ActiveUrl'
WorkspaceController = require './WorkspaceController'
WorkspaceUrl        = require './WorkspaceUrl'
StackPanel          = require './components/StackPanel'
CardPanel           = require './components/CardPanel'
WorkspaceSidebar    = require './components/WorkspaceSidebar'
CardStore           = require './stores/CardStore'
OrganizationStore   = require './stores/OrganizationStore'
StackStore          = require './stores/StackStore'
TeamStore           = require './stores/TeamStore'
TypeStore           = require './stores/TypeStore'
UserStore           = require './stores/UserStore'
{div}               = React.DOM

controller = new WorkspaceController
  cards:         new CardStore()
  organizations: new OrganizationStore()
  stacks:        new StackStore()
  teams:         new TeamStore()
  types:         new TypeStore()
  users:         new UserStore()

WorkspaceScreen = React.createClass {

  mixins: [
    Flux('cards', 'organizations', 'stacks', 'teams', 'types', 'users')
    ActiveUrl(WorkspaceUrl)
    Router.Navigation
  ]

  getDefaultProps: ->
    {controller}

  getInitialState: ->
    return {
      channel:       undefined
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

    div {className: 'workspace screen'}, [
      NavigationBar {key: 'navigation-bar', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
      div {key: 'main', className: 'main'}, [
        WorkspaceSidebar {stacks: @state.stacks, teams: @state.teams}
        PanelGroup {}, @getActivePanels()
      ]
      PresenceBar {key: 'presence-bar', currentUser: @state.currentUser}
    ]

  getActivePanels: ->
    urlModel = @getActiveUrl()
    position = 0
    stackPanels = _.map urlModel.stacks, (stackId) =>
      StackPanel {stackId, key: "stack-#{stackId}", position: position++}
    cardPanels = _.map urlModel.cards, (cardId) =>
      CardPanel {cardId, key: "card-#{cardId}", position: position++}
    return stackPanels.concat(cardPanels)

  startDraggingCard: (draggingCard, draggingIndex) ->
    @setState {draggingCard, draggingIndex}

  stopDraggingCard: ->
    @setState {draggingCard: undefined, draggingIndex: undefined}

  hoveringOver: (hoveringCard, hoveringIndex) ->
    @setState {hoveringCard, hoveringIndex}
}

module.exports = WorkspaceScreen
