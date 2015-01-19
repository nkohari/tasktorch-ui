React          = require 'react'
PropTypes      = require 'common/PropTypes'
Observe        = require 'mixins/Observe'
Icon           = React.createFactory(require 'common/Icon')
OverlayTrigger = React.createFactory(require 'common/OverlayTrigger')
TooltipOverlay = React.createFactory(require 'common/TooltipOverlay')
{div}          = React.DOM

ActionStatus = React.createClass {

  displayName: 'ActionStatus'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  render: ->
    
    overlay = TooltipOverlay {text: @props.action.status}

    OverlayTrigger {placement: 'right', trigger: 'click', overlay},
      div {key: 'status', className: 'status'}, [
        Icon {key: 'icon', name: "action-#{@props.action.status.toLowerCase()}"}
      ]

}

module.exports = ActionStatus
