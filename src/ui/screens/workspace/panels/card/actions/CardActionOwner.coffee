#--------------------------------------------------------------------------------
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Avatar             = React.createFactory(require 'ui/common/Avatar')
Icon               = React.createFactory(require 'ui/common/Icon')
OverlayTrigger     = React.createFactory(require 'ui/common/OverlayTrigger')
ActionOwnerOverlay = React.createFactory(require 'ui/overlays/ActionOwnerOverlay')
#--------------------------------------------------------------------------------
require './CardActionOwner.styl'
#--------------------------------------------------------------------------------

CardActionOwner = React.createClass {

  displayName: 'CardActionOwner'

  propTypes:
    action: PropTypes.Action

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.action.user) if @props.action.user?
  }

  isReady: ->
    @state.user? or not @props.action.user?

  render: ->

    if @state.user?
      contents = Avatar {user: @state.user}
    else
      contents = Icon {name: 'user'}

    overlay = ActionOwnerOverlay {action: @props.action}
    OverlayTrigger {@isReady, className: 'card-action-owner', overlay},
      contents

}

module.exports = CardActionOwner
