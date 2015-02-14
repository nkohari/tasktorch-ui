_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'framework/PropTypes'
List          = React.createFactory(require 'ui/common/List')
FollowingCard = React.createFactory(require 'ui/panels/following/FollowingCard')

FollowingCardList = React.createClass {

  displayName: 'FollowingCardList'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    cards = _.map @props.cards, (card) ->
      FollowingCard {key: card.id, card}

    List {className: 'cards'}, cards

}

module.exports = FollowingCardList
