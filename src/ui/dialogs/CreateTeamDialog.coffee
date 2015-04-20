React                = require 'react'
UserCreatedTeamEvent = require 'events/ui/UserCreatedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')
MembershipEditor     = React.createFactory(require 'ui/common/MembershipEditor')

CreateTeamDialog = React.createClass {

  displayName: 'CreateTeamDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    name:    ''
    purpose: ''
    leaders: []
    members: []
  }

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Create Team', onClick: @createTeam, disabled: !@isComplete()}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'team', width: 700, height: 560, className: 'create-team', title: 'Create a Team', buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name'},
        Input {ref: 'name', placeholder: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', value: @state.name, onChange: @onNameChanged}
      Field {label: 'Purpose'},
        Input {ref: 'purpose', placeholder: 'ex. Product Development, Customer Happiness, World Domination', value: @state.purpose, onChange: @onPurposeChanged}
      Field {label: 'Members', className: 'members'},
        MembershipEditor {leaders: @state.leaders, members: @state.members}

  isComplete: ->
    @state.name?.length > 0 and @state.members?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  onPurposeChanged: (event) ->
    @setState {purpose: event.target.value}

  createTeam: ->
    @publish new UserCreatedTeamEvent(@state.name, @state.purpose, @state.members, @state.leaders)
    @props.closeDialog()

}

module.exports = CreateTeamDialog
