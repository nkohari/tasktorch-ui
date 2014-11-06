_                    = require 'lodash'
React                = require 'react/addons'
Router               = require 'react-router'
Flux                 = require 'mixins/Flux'
ActiveUrl            = require 'mixins/ActiveUrl'
WorkspaceEnvironment = require './WorkspaceEnvironment'
WorkspaceUrl         = require './WorkspaceUrl'
PanelGroup           = React.createFactory(require 'common/PanelGroup')
StackPanel           = React.createFactory(require './components/StackPanel')
CardPanel            = React.createFactory(require './components/CardPanel')
WorkspaceSidebar     = React.createFactory(require './components/WorkspaceSidebar')
{div}                = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  mixins: [
    Flux()
    ActiveUrl(WorkspaceUrl)
    Router.Navigation
  ]

  propTypes:
    currentOrganization: React.PropTypes.object.isRequired
    currentUser:         React.PropTypes.object.isRequired

  getDefaultProps: ->
    {controller: WorkspaceEnvironment.createController()}

  getInitialState: ->
    return {
      draggingCard:  undefined
      draggingIndex: undefined
      hoveringCard:  undefined
      hoveringIndex: undefined
    }

  componentWillMount: ->
    window.Screen = this
    controller = @getController()
    controller.setCurrentOrganization(@props.currentOrganization.id)
    controller.loadWorkspace()

  componentWillUnmount: ->
    window.Screen = undefined

  render: ->
    url = @getActiveUrl()
    position = 0
    stackPanels = _.map url.stacks, (stackId) =>
      StackPanel {key: "stack-#{stackId}", stackId, position: position++}
    cardPanels = _.map url.cards, (cardId) =>
      CardPanel {key: "card-#{cardId}", cardId, position: position++}

    div {className: 'workspace screen'}, [
      WorkspaceSidebar {key: 'sidebar'}
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
