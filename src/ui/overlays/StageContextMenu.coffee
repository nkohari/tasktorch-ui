#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM
#--------------------------------------------------------------------------------

StageContextMenu = React.createClass {

  displayName: 'StageContextMenu'

  propTypes:
    stage:       PropTypes.Stage
    hideOverlay: PropTypes.func
    startAdding: PropTypes.func

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      a {onClick: @props.startAdding},
        Icon {name: 'action'}
        'Add default actions'
      DialogTrigger {name: 'DeleteStage', stageid: @props.stage.id},
        Icon {name: 'trash'}
        'Delete this stage'

}

module.exports = StageContextMenu
