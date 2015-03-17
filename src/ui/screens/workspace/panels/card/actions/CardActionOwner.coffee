React                    = require 'react'
PropTypes                = require 'ui/framework/PropTypes'
CachedState              = require 'ui/framework/mixins/CachedState'
Avatar                   = React.createFactory(require 'ui/common/Avatar')
Icon                     = React.createFactory(require 'ui/common/Icon')
OverlayTrigger           = React.createFactory(require 'ui/common/OverlayTrigger')
ChangeActionOwnerOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/actions/overlays/ChangeActionOwnerOverlay')

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
      contents = Icon {name: 'assign'}

    overlay = ChangeActionOwnerOverlay {action: @props.action}

    OverlayTrigger {@isReady, className: 'owner', overlay},
      contents

}

module.exports = CardActionOwner
