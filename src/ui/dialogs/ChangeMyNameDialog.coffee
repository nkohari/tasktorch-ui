React                = require 'react'
UserChangedNameEvent = require 'events/ui/UserChangedNameEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
ShellContext         = require 'ui/framework/mixins/ShellContext'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')

ChangeMyNameDialog = React.createClass {

  displayName: 'ChangeMyNameDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, ShellContext]

  getInitialState: -> {
    name: @getCurrentUser().name
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Change Name', className: 'default', disabled: !@isValid(), onClick: @changeName}
      Button {text: 'Cancel', onClick: @props.closeDialog}

    Dialog {icon: 'settings', title: 'Change My Name', buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name', hint: 'username'},
        Input {ref: 'name', placeholder: 'Enter a name', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  changeName: ->
    @publish new UserChangedNameEvent(@state.name)
    @props.closeDialog()

}

module.exports = ChangeMyNameDialog
