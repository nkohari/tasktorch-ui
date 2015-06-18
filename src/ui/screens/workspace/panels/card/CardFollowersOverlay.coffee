#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Avatar         = React.createFactory(require 'ui/common/Avatar')
Overlay        = React.createFactory(require 'ui/common/Overlay')
{ul, li, span} = React.DOM
#--------------------------------------------------------------------------------
require './CardFollowersOverlay.styl'
#--------------------------------------------------------------------------------

CardFollowersOverlay = React.createClass {

  displayName: 'CardFollowersOverlay'

  propTypes:
    card:        PropTypes.Card
    hideOverlay: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) -> {
    followers: cache('followersByCard').get(@props.card.id)
  }

  isReady: ->
    @state.followers?

  render: ->

    items = _.map @state.followers, (user) =>
      li {key: user.id},
        Avatar {user}
        span {className: 'name'}, user.name

    Overlay {@isReady, arrow: true, hideOverlay: @props.hideOverlay},
      ul {className: 'card-followers'}, items

}

module.exports = CardFollowersOverlay
