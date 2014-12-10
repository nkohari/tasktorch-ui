_           = require 'lodash'
React       = require 'react'
BacklogCard = React.createFactory(require './BacklogCard')
{ul}        = React.DOM

BacklogCardList = React.createClass {

  displayName: 'BacklogCardList'

  render: ->
    ul {className: 'queue cards'}, @renderChildren()

  renderChildren: ->
    _.map @props.cards, (card) =>
      BacklogCard {key: "card-#{card.id}", stack: @props.stack, card}

}

module.exports = BacklogCardList
