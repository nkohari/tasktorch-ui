#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
#--------------------------------------------------------------------------------

StageContextMenu = React.createClass {

  displayName: 'StageContextMenu'

  propTypes:
    stage:        PropTypes.Stage
    hideOverlay:  PropTypes.func
    toggleAdding: PropTypes.func

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'DeleteStage', stageid: @props.stage.id},
        Icon {name: 'trash'}
        'Delete this stage'

}

module.exports = StageContextMenu
