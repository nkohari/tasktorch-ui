#--------------------------------------------------------------------------------
React                = require 'react'
UserChangedNameEvent = require 'events/ui/UserChangedNameEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
IdentityContext      = require 'ui/framework/mixins/IdentityContext'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter         = React.createFactory(require 'ui/common/DialogFooter')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')
#--------------------------------------------------------------------------------

ChangeMyNameDialog = React.createClass {

  displayName: 'ChangeMyNameDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: -> {
    name: @getCurrentUser().name
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Name', className: 'default', disabled: !@isValid(), onClick: @changeName}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'settings', title: 'Change My Name', footer, closeDialog: @props.closeDialog},
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
