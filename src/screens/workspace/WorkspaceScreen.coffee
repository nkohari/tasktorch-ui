_                   = require 'lodash'
React               = require 'react/addons'
Router              = require 'react-router'
ActiveUrl           = require 'mixins/ActiveUrl'
Observe             = require 'mixins/Observe'
LoadAllKindsRequest = require 'requests/LoadAllKindsRequest'
WorkspaceUrl        = require './WorkspaceUrl'
StackPanel          = React.createFactory(require './components/stack/StackPanel')
CardPanel           = React.createFactory(require './components/card/CardPanel')
WorkspaceSidebar    = React.createFactory(require './components/sidebar/WorkspaceSidebar')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
{div}               = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  mixins: [
    Observe()
    ActiveUrl(WorkspaceUrl)
    Router.Navigation
  ]

  getInitialState: ->
    return {
      draggingCard:  undefined
      draggingIndex: undefined
      hoveringCard:  undefined
      hoveringIndex: undefined
    }

  componentWillMount: ->
    # TODO: This is for drag&drop, replace it with something sane
    window.Screen = this
    @execute new LoadAllKindsRequest()

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
      CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide'}, stackPanels.concat(cardPanels)
    ]

  startDraggingCard: (draggingCard, draggingIndex) ->
    @setState {draggingCard, draggingIndex}

  stopDraggingCard: ->
    @setState {draggingCard: undefined, draggingIndex: undefined}

  hoveringOver: (hoveringCard, hoveringIndex) ->
    @setState {hoveringCard, hoveringIndex}
}

module.exports = WorkspaceScreen
