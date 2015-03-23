React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
Icon                      = React.createFactory(require 'ui/common/Icon')
OverlayTrigger            = React.createFactory(require 'ui/common/OverlayTrigger')
ChangeActionStatusOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/actions/overlays/ChangeActionStatusOverlay')

CardActionStatus = React.createClass {

  displayName: 'CardActionStatus'

  propTypes:
    action: PropTypes.Action

  render: ->

    overlay = ChangeActionStatusOverlay {action: @props.action}

    OverlayTrigger {className: 'card-action-status', overlay},
      Icon {name: "action-#{@props.action.status.toLowerCase()}"}

}

module.exports = CardActionStatus
