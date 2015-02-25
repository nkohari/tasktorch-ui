_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Pure      = require 'ui/framework/mixins/Pure'
Frame     = React.createFactory(require 'ui/common/Frame')
Icon      = React.createFactory(require 'ui/common/Icon')

CardFollowerCount = React.createClass {

  displayName: 'CardFollowerCount'

  propTypes:
    card: PropTypes.Card

  mixins: [Pure]

  render: ->

    count = @props.card.followers.length

    Frame {className: 'followers'},
      Icon {name: 'users'}
      count
      "Follower#{if count == 1 then '' else 's'}"

}

module.exports = CardFollowerCount

