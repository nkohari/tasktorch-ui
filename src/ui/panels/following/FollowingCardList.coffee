_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'framework/PropTypes'
Frame         = React.createFactory(require 'ui/common/Frame')
List          = React.createFactory(require 'ui/common/List')
FollowingCard = React.createFactory(require 'ui/panels/following/FollowingCard')

FollowingCardList = React.createClass {

  displayName: 'FollowingCardList'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    cards = _.map @props.cards, (card) ->
      FollowingCard {key: card.id, card}

    Frame {className: 'cards'},
      Frame {className: 'group'},
        Frame {className: 'header'}, 'Changed'
        List {}
      Frame {className: 'group'},
        Frame {className: 'header'}, 'Unchanged'
        List {}, cards

}

module.exports = FollowingCardList
