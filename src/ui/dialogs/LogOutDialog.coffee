React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Button        = React.createFactory(require 'ui/common/Button')
Dialog        = React.createFactory(require 'ui/common/Dialog')
DialogButtons = React.createFactory(require 'ui/common/DialogButtons')
{div}         = React.DOM

LogOutDialog = React.createClass {

  displayName: 'LogOutDialog'

  propTypes:
    closeDialog: PropTypes.func

  render: ->

    Dialog {icon: 'logout', title: 'Log Out', width: 400, closeDialog: @props.closeDialog},
      'Are you sure you want to log out?'
      DialogButtons {},
        Button {text: 'Log Out', onClick: @props.closeDialog}
        Button {text: 'Cancel',  onClick: @props.closeDialog}

}

module.exports = LogOutDialog
