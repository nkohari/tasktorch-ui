#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
ContextMenu = React.createFactory(require 'ui/common/ContextMenu')
Icon        = React.createFactory(require 'ui/common/Icon')
MenuOption  = React.createFactory(require 'ui/common/MenuOption')
{a}         = React.DOM
#--------------------------------------------------------------------------------

CardChecklistContextMenu = React.createClass {

  displayName: 'CardChecklistContextMenu'

  propTypes:
    checklist:   PropTypes.Checklist
    hideOverlay: PropTypes.func
    startAdding: PropTypes.func

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      MenuOption {onActivated: @props.startAdding},
        Icon {name: 'action'}
        'Add actions'

}

module.exports = CardChecklistContextMenu
