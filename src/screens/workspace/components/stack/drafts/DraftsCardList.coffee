_          = require 'lodash'
React      = require 'react'
DraftsCard = React.createFactory(require './DraftsCard')
{ul}       = React.DOM

DraftsCardList = React.createClass {

  displayName: 'DraftsCardList'

  render: ->
    ul {className: 'drafts cards'}, @renderChildren()

  renderChildren: ->
    _.map @props.cards, (card) =>
      DraftsCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = DraftsCardList
