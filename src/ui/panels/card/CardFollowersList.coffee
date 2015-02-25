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
    owner:       cache('users').get(@props.card.owner) if @props.card.owner?
    users:       cache('followersByCard').get(@props.card.id)
  }

  isReady: ->
    @state.currentUser? and (@state.owner? or not @props.card.owner?) and @state.users?

  render: ->

    items = _.map @state.users, (user) =>
      li {key: "user-#{user.id}", className: 'follower'},
        Avatar {user, size: 32}

    List {@isReady, className: 'followers'}, items

}

module.exports = CardFollowersList
