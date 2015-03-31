React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Button        = React.createFactory(require 'ui/common/Button')
Dialog        = React.createFactory(require 'ui/common/Dialog')
DialogButtons = React.createFactory(require 'ui/common/DialogButtons')
{div}         = React.DOM

UserSettingsDialog = React.createClass {

  displayName: 'UserSettingsDialog'

  propTypes:
    closeDialog: PropTypes.func

  render: ->

    Dialog {icon: 'settings', title: 'Preferences', closeDialog: @props.closeDialog},
      'Nothing to configure yet',
      DialogButtons {},
        Button {text: 'Close', onClick: @props.closeDialog}

}

module.exports = UserSettingsDialog
