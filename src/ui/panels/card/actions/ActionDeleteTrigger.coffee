React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
Pure                = require 'ui/framework/mixins/Pure'
Icon                = React.createFactory(require 'ui/common/Icon')
OverlayTrigger      = React.createFactory(require 'ui/common/OverlayTrigger')
DeleteActionOverlay = React.createFactory(require 'ui/panels/card/actions/overlays/DeleteActionOverlay')

ActionDeleteTrigger = React.createClass {

  displayName: 'ActionDeleteTrigger'

  propTypes:
    action: PropTypes.Action

  mixins: [Pure]

  render: ->

    overlay = DeleteActionOverlay {action: @props.action}

    OverlayTrigger {className: 'delete', overlay},
      Icon {name: 'trash'}

}

module.exports = ActionDeleteTrigger
