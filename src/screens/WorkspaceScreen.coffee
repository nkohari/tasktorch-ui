_                = require 'lodash'
React            = require 'react/addons'
Router           = require 'react-router'
Api              = require '../Api'
PanelGroup       = require '../components/PanelGroup'
WorkspaceSidebar = require '../components/WorkspaceSidebar'
StackColumn      = require '../components/StackColumn'
CardDetail       = require '../components/CardDetail'
{div}            = React.DOM

WorkspaceScreen = React.createClass {

  mixins: [Router.ActiveState, Router.Navigation],

  getInitialState: ->
    return {
      user:         undefined
      organization: undefined
      types:        []
      teams:        []
      stacks:       {inbox: undefined, queue: undefined, backlog: []}
      openStacks:   []
      openCards:    []
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
    div {className: 'workspace screen'}, [
      WorkspaceSidebar {user: @state.user, organization: @state.organization, stacks: @state.stacks, teams: @state.teams, openStacks: @state.openStacks}
      PanelGroup {}, @getOpenPanels()
    ]

  getOpenPanels: ->
    position = 0
    stackPanels = _.map @state.openStacks, (stack) =>
      StackColumn {stack, key: "stack-#{stack.id}", position: position++, openCards: @state.openCards, draggingCard: @state.draggingCard}
    cardPanels = _.map @state.openCards, (card) =>
      CardDetail {card, key: "card-#{card.id}", position: position++}
    return stackPanels.concat(cardPanels)

  startDraggingCard: (card) ->
    @setState {draggingCard: card}

  stopDraggingCard: ->
    @setState {draggingCard: undefined}

  openStack: (stack) ->
    return if _.contains(@state.openStacks, stack)
    @setState {openStacks: @state.openStacks.concat(stack)}

  closeStack: (stack) ->
    return unless _.contains(@state.openStacks, stack)
    @setState {openStacks: _.without(@state.openStacks, stack)}

  openCard: (card) ->
    return if _.contains(@state.openCards, card)
    @setState {openCards: @state.openCards.concat(card)}

  closeCard: (card) ->
    return unless _.contains(@state.openCards, card)
    @setState {openCards: _.without(@state.openCards, card)}

}

module.exports = WorkspaceScreen
