_                       = require 'lodash'
React                   = require 'react'
Observe                 = require 'mixins/Observe'
LoadCardsInStackRequest = require 'requests/LoadCardsInStackRequest'
BacklogCard             = React.createFactory(require './BacklogCard')
{ul}                    = React.DOM

BacklogCardList = React.createClass {

  displayName: 'BacklogCardList'

  mixins: [Observe('cards')]

  getStateFromStores: (stores) ->
    {cards: stores.cards.getCards(_.pluck(@props.stack.cards, 'id'))}

  componentWillMount: ->
    @execute new LoadCardsInStackRequest(@props.stack.id)

  isReady: ->
    @state.cards?

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    ul {className: 'queue cards'}, @getChildren()

  renderChildren: ->
    _.map @state.cards, (card) =>
      BacklogCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = BacklogCardList
