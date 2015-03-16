_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Block         = React.createFactory(require 'ui/common/Block')
Frame         = React.createFactory(require 'ui/common/Frame')
List          = React.createFactory(require 'ui/common/List')
FollowingCard = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingCard')

FollowingCardList = React.createClass {

  displayName: 'FollowingCardList'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    cards = _.map @props.cards, (card) ->
      FollowingCard {key: card.id, card}

    Frame {className: 'cards'},
      Block {title: 'Changed'},
        List {}
      Block {title: 'Unchanged'},
        List {}, cards

}

module.exports = FollowingCardList
