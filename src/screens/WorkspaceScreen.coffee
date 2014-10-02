_           = require 'lodash'
React       = require 'react/addons'
Loader      = require '../Loader'
PanelGroup  = require '../components/PanelGroup'
StackList   = require '../components/StackList'
StackColumn = require '../components/StackColumn'
CardDetail  = require '../components/CardDetail'
{div}       = React.DOM

WorkspaceScreen = React.createClass {

  getInitialState: ->
    {stacks: [], openStacks: [], openCards: [], draggingCard: undefined}

  componentWillMount: ->
    window.Screen = this
    Loader.getMyStacks (err, stacks) => @setState {stacks}

  componentWillUnmount: ->
    window.Screen = undefined

  render: ->
    div {className: 'workspace screen'}, [
      StackList {stacks: @state.stacks, openStacks: @state.openStacks}
      PanelGroup {}, @getOpenPanels()
    ]

  getOpenPanels: ->
    position = 0
    stackPanels = _.map @state.openStacks, (stack) =>
      StackColumn {stack, key: stack.id, position: position++, openCards: @state.openCards, draggingCard: @state.draggingCard}
    cardPanels = _.map @state.openCards, (card) =>
      CardDetail {card, key: card.id, position: position++}
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
