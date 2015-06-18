#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
Icon                 = React.createFactory(require 'ui/common/Icon')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
CardFollowersOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/CardFollowersOverlay')
{span}               = React.DOM
#--------------------------------------------------------------------------------

CardFollowers = React.createClass {

  displayName: 'CardFollowers'

  propTypes:
    card: PropTypes.Card

  render: ->

    overlay = CardFollowersOverlay {card: @props.card}

    if @props.card?
      count  = @props.card.followers.length
      plural = if count == 1 then '' else 's'
      label  = "#{count} Follower#{plural}"
    else
      label  = "0 Followers"

    OverlayTrigger {className: 'followers card-widget', overlay},
      span {},
        Icon {name: 'followers'}
        label

}

module.exports = CardFollowers
