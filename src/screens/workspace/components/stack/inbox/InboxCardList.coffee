_         = require 'lodash'
React     = require 'react'
InboxCard = React.createFactory(require './InboxCard')
{ul}      = React.DOM

InboxCardList = React.createClass {

  displayName: 'InboxCardList'

  render: ->
    ul {className: 'inbox cards'}, @renderChildren()

  renderChildren: ->
    _.map @props.cards, (card) =>
      InboxCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = InboxCardList
