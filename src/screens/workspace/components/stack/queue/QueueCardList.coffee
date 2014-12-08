_                       = require 'lodash'
React                   = require 'react'
Observe                 = require 'mixins/Observe'
LoadCardsInStackRequest = require 'requests/LoadCardsInStackRequest'
QueueCard               = React.createFactory(require './QueueCard')
{ul}                    = React.DOM

QueueCardList = React.createClass {

  displayName: 'QueueCardList'

  mixins: [Observe('cards')]

  getStateFromStores: (stores) ->
    {cards: stores.cards.getCards(_.pluck(@props.stack.cards, 'id'))}

  componentWillMount: ->
    # TODO: Load actions too, depending on what QueueCard wants
    @execute new LoadCardsInStackRequest(@props.stack.id)

  isReady: ->
    @state.cards?

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    ul {className: 'queue cards'}, @getChildren()

  renderChildren: ->
    _.map @state.cards, (card) =>
      QueueCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = QueueCardList
