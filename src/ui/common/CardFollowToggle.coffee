_                       = require 'lodash'
React                   = require 'react'
classSet                = require 'common/util/classSet'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
CurrentUserAware        = require 'ui/framework/mixins/CurrentUserAware'
UserFollowedCardEvent   = require 'events/ui/UserFollowedCardEvent'
UserUnfollowedCardEvent = require 'events/ui/UserUnfollowedCardEvent'
Frame                   = React.createFactory(require 'ui/common/Frame')
Icon                    = React.createFactory(require 'ui/common/Icon')
{a}                     = React.DOM

CardFollowToggle = React.createClass {

  displayName: 'CardFollowToggle'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CurrentUserAware]

  render: ->

    isFollowing = @isFollowing()

    classes = classSet [
      'follow-toggle'
      'active' if isFollowing
    ]

    a {className: 'trigger', onClick: @toggleFollowing},
      Icon {name: if isFollowing then 'follow' else 'follow-open'}

  isFollowing: ->
    _.contains(@props.card.followers, @getCurrentUser().id)

  toggleFollowing: (event) ->
    event.stopPropagation()
    currentUser = @getCurrentUser()
    if @isFollowing()
      @publish new UserUnfollowedCardEvent(@props.card.id, currentUser.id)
    else
      @publish new UserFollowedCardEvent(@props.card.id, currentUser.id)

}

module.exports = CardFollowToggle
