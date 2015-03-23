_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Avatar      = React.createFactory(require 'ui/common/Avatar')
List        = React.createFactory(require 'ui/common/List')
{li}        = React.DOM

CardFollowersList = React.createClass {

  displayName: 'CardFollowersList'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    currentUser: cache('users').get(@props.currentUser.id)
    followers:   cache('followersByCard').get(@props.card.id)
  }

  isReady: ->
    @state.currentUser? and @state.followers?

  render: ->

    items = _.map @state.followers, (user) =>
      li {key: "user-#{user.id}", className: 'follower'},
        Avatar {user, size: 32}

    List {@isReady, className: 'card-followers-list'}, items

}

module.exports = CardFollowersList
