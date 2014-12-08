_                       = require 'lodash'
React                   = require 'react'
Observe                 = require 'mixins/Observe'
LoadCardsInInboxRequest = require 'requests/LoadCardsInInboxRequest'
InboxCard               = React.createFactory(require './InboxCard')
{ul}                    = React.DOM

InboxCardList = React.createClass {

  displayName: 'InboxCardList'

  mixins: [Observe('cards')]

  getStateFromStores: (stores) ->
    {cards: stores.cards.getCards(_.pluck(@props.stack.cards, 'id'))}

  componentWillMount: ->
    @execute new LoadCardsInInboxRequest(@props.stack.id)

  isReady: ->
    @state.cards?

  getChildren: ->
    if @isReady() then @renderChildren() else []

  render: ->
    ul {className: 'inbox cards'}, @getChildren()

  renderChildren: ->
    _.map @state.cards, (card) =>
      InboxCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = InboxCardList
