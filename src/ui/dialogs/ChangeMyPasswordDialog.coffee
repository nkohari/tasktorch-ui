#--------------------------------------------------------------------------------
React                    = require 'react'
UserChangedPasswordEvent = require 'events/ui/UserChangedPasswordEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
Button                   = React.createFactory(require 'ui/common/Button')
Dialog                   = React.createFactory(require 'ui/common/Dialog')
DialogButtons            = React.createFactory(require 'ui/common/DialogButtons')
Field                    = React.createFactory(require 'ui/common/Field')
Input                    = React.createFactory(require 'ui/common/Input')
#--------------------------------------------------------------------------------

ChangeMyPasswordDialog = React.createClass {

  displayName: 'ChangeMyPasswordDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    password: ''
    repeat:   ''
  }

  componentDidMount: ->
    @refs.password.focus()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Change Password', className: 'default', disabled: !@isValid(), onClick: @changePassword}
      Button {text: 'Cancel', onClick: @props.closeDialog}

    Dialog {icon: 'settings', title: 'Change My Password', buttons, closeDialog: @props.closeDialog},
      Field {label: 'New Password'},
        Input {ref: 'password', type: 'password', icon: 'secure', placeholder: 'Enter a new password', value: @state.password, onChange: @onPasswordChanged}
      Field {label: 'New Password (again)'},
        Input {type: 'password', icon: 'secure', placeholder: 'Repeat the same password to confirm', value: @state.repeat, onChange: @onRepeatChanged}

  isValid: ->
    @state.password?.length > 0 and @state.repeat == @state.password

  onPasswordChanged: (event) ->
    @setState {password: event.target.value}

  onRepeatChanged: (event) ->
    @setState {repeat: event.target.value}

  changePassword: ->
    @publish new UserChangedPasswordEvent(@state.password)
    @props.closeDialog()

}

module.exports = ChangeMyPasswordDialog
