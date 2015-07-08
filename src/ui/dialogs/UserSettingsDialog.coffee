#--------------------------------------------------------------------------------
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Button        = React.createFactory(require 'ui/common/Button')
Dialog        = React.createFactory(require 'ui/common/Dialog')
DialogFooter = React.createFactory(require 'ui/common/DialogFooter')
{div}         = React.DOM
#--------------------------------------------------------------------------------

UserSettingsDialog = React.createClass {

  displayName: 'UserSettingsDialog'

  propTypes:
    closeDialog: PropTypes.func

  render: ->

    footer = DialogFooter {
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'settings', title: 'Preferences', footer, closeDialog: @props.closeDialog},
      'Nothing to configure yet',

}

module.exports = UserSettingsDialog
