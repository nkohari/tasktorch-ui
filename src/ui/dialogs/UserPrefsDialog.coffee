React     = require 'react'
PropTypes = require 'framework/PropTypes'
Button    = React.createFactory(require 'ui/common/Button')
Dialog    = React.createFactory(require 'ui/common/Dialog')
{div}     = React.DOM

UserPrefsDialog = React.createClass {

  displayName: 'UserPrefsDialog'

  propTypes:
    close: PropTypes.func

  render: ->

    Dialog {icon: 'settings', title: 'Preferences', close: @props.close},
      'Nothing to configure yet',
      div {className: 'dialog-buttons'},
        Button {text: 'Close', onClick: @props.close}

}

module.exports = UserPrefsDialog
