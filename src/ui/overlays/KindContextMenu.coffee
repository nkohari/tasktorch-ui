#--------------------------------------------------------------------------------
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
ShellContext         = require 'ui/framework/mixins/ShellContext'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
#--------------------------------------------------------------------------------

KindContextMenu = React.createClass {

  displayName: 'KindContextMenu'

  propTypes:
    kindid:      PropTypes.string
    hideOverlay: PropTypes.func

  mixins: [CachedState, ShellContext]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.kindid)
  }

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'RenameKind', kindid: @props.kindid},
        Icon {name: 'edit'}
        'Rename'
      DialogTrigger {name: 'ChangeKindColor', kindid: @props.kindid},
        Icon {name: 'edit'}
        'Change color'
      DialogTrigger {name: 'ChangeKindDescription', kindid: @props.kindid},
        Icon {name: 'edit'}
        'Change description'
      DialogTrigger {name: 'ChangeKindWorkflow', kindid: @props.kindid},
        Icon {name: 'workflow'}
        'Change workflow'
      ContextMenuSeparator {}
      DialogTrigger {name: 'DeleteKind', kindid: @props.kindid},
        Icon {name: 'trash'}
        'Delete'

}

module.exports = KindContextMenu
