_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
List      = React.createFactory(require 'ui/common/List')

FollowingCardList = React.createClass {

  displayName: 'FollowingCardList'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    List {className: 'cards'}

}

module.exports = FollowingCardList
