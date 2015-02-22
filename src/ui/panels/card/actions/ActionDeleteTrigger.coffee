React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Icon                = React.createFactory(require 'ui/common/Icon')
OverlayTrigger      = React.createFactory(require 'ui/common/OverlayTrigger')
DeleteActionOverlay = React.createFactory(require 'ui/panels/card/actions/overlays/DeleteActionOverlay')

ActionDeleteTrigger = React.createClass {

  displayName: 'ActionDeleteTrigger'

  propTypes:
    action: PropTypes.Action

  render: ->

    overlay = DeleteActionOverlay {action: @props.action}

    OverlayTrigger {className: 'delete', overlay},
      Icon {name: 'trash'}

}

module.exports = ActionDeleteTrigger
