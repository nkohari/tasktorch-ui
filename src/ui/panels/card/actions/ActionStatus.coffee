React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
Icon                      = React.createFactory(require 'ui/common/Icon')
OverlayTrigger            = React.createFactory(require 'ui/common/OverlayTrigger')
ChangeActionStatusOverlay = React.createFactory(require 'ui/panels/card/actions/overlays/ChangeActionStatusOverlay')

ActionStatus = React.createClass {

  displayName: 'ActionStatus'

  propTypes:
    action: PropTypes.Action

  render: ->

    overlay = ChangeActionStatusOverlay {action: @props.action}

    OverlayTrigger {className: 'status', overlay},
      Icon {name: "action-#{@props.action.status.toLowerCase()}"}

}

module.exports = ActionStatus
