_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Block         = React.createFactory(require 'ui/common/Block')
FollowingCard = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingCard')
{div, ul}     = React.DOM

FollowingCardList = React.createClass {

  displayName: 'FollowingCardList'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    cards = _.map @props.cards, (card) ->
      FollowingCard {key: card.id, card}

    div {className: 'following-card-list'},
      Block {title: 'Changed'},
        ul {}
      Block {title: 'Unchanged'},
        ul {}, cards

}

module.exports = FollowingCardList
