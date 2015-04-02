_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{div}                = React.DOM

StackContextMenu = React.createClass {

  displayName: 'StackContextMenu'

  propTypes:
    stack:       PropTypes.Stack
    hideOverlay: PropTypes.func

  render: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'RenameStack', stack: @props.stack},
        Icon {name: 'edit'}
        'Rename this stack'
      ContextMenuSeparator {}
      DialogTrigger {name: 'DeleteStack', stack: @props.stack},
        Icon {name: 'trash'}
        'Delete this stack'
}

module.exports = StackContextMenu
