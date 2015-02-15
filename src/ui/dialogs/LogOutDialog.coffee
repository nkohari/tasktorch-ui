React     = require 'react'
PropTypes = require 'framework/PropTypes'
Button    = React.createFactory(require 'ui/common/Button')
Dialog    = React.createFactory(require 'ui/common/Dialog')
{div}     = React.DOM

LogOutDialog = React.createClass {

  displayName: 'LogOutDialog'

  propTypes:
    close: PropTypes.func

  render: ->

    Dialog {icon: 'logout', title: 'Log Out', width: 400, close: @props.close},
      'Are you sure you want to log out?'
      div {className: 'dialog-buttons'},
        Button {text: 'Log Out', onClick: @props.close}
        Button {text: 'Cancel',  onClick: @props.close}

}

module.exports = LogOutDialog
