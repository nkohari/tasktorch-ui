React                 = require 'react'
UserChangedEmailEvent = require 'events/ui/UserChangedEmailEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
ShellContext          = require 'ui/framework/mixins/ShellContext'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')
Field                 = React.createFactory(require 'ui/common/Field')
Input                 = React.createFactory(require 'ui/common/Input')

ChangeMyEmailDialog = React.createClass {

  displayEmail: 'ChangeMyEmailDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, ShellContext]

  getInitialState: -> {
    email: @getCurrentUser().email
  }

  componentDidMount: ->
    @refs.email.focus()
    @refs.email.select()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Change Email', className: 'default', disabled: !@isValid(), onClick: @changeEmail}
      Button {text: 'Cancel', onClick: @props.closeDialog}

    hint = """
      If you enter an email address associated with a Gravatar account, it will be used
      for your avatar on TaskTorch.
    """

    Dialog {icon: 'settings', title: 'Change My Email', buttons, closeDialog: @props.closeDialog},
      Field {label: 'Email', hint},
        Input {ref: 'email', icon: 'email', placeholder: 'Enter an email address', value: @state.email, onChange: @onEmailChanged}

  isValid: ->
    @state.email?.length > 0

  onEmailChanged: (event) ->
    @setState {email: event.target.value}

  changeEmail: ->
    @publish new UserChangedEmailEvent(@state.email)
    @props.closeDialog()

}

module.exports = ChangeMyEmailDialog
