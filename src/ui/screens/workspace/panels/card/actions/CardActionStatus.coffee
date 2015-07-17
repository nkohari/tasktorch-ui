#--------------------------------------------------------------------------------
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Icon             = React.createFactory(require 'ui/common/Icon')
OverlayTrigger   = React.createFactory(require 'ui/common/OverlayTrigger')
ActionStatusMenu = React.createFactory(require 'ui/overlays/ActionStatusMenu')
#--------------------------------------------------------------------------------
require './CardActionStatus.styl'
#--------------------------------------------------------------------------------

CardActionStatus = React.createClass {

  displayName: 'CardActionStatus'

  propTypes:
    action: PropTypes.Action

  render: ->

    OverlayTrigger {className: 'card-action-status', overlay: ActionStatusMenu {action: @props.action}},
      Icon {name: @props.action.status.toLowerCase()}

}

module.exports = CardActionStatus
