#--------------------------------------------------------------------------------
React                = require 'react'
UserCreatedGoalEvent = require 'events/ui/UserCreatedGoalEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
IdentityContext      = require 'ui/framework/mixins/IdentityContext'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter         = React.createFactory(require 'ui/common/DialogFooter')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')
#--------------------------------------------------------------------------------

CreateGoalDialog = React.createClass {

  displayEmail: 'CreateGoalDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: -> {
    name: ''
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Create Goal', className: 'default', disabled: !@isValid(), onClick: @createGoal}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'goal', title: 'Create a Goal', footer, closeDialog: @props.closeDialog},
      Field {label: 'Name', hint: 'create-goal'},
        Input {ref: 'name', placeholder: 'ex. Beta Release, Project X, Save Money', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  createGoal: ->
    @publish new UserCreatedGoalEvent(@getCurrentOrg().id, @state.name)
    @props.closeDialog()

}

module.exports = CreateGoalDialog
