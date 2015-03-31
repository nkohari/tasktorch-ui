React                = require 'react'
UserCreatedTeamEvent = require 'events/ui/UserCreatedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
FieldGroup           = React.createFactory(require 'ui/common/FieldGroup')
MembershipEditor     = React.createFactory(require 'ui/common/MembershipEditor')
{div, input}         = React.DOM

CreateTeamDialog = React.createClass {

  displayName: 'CreateTeamDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    dirty: false
    name:  ''
  }

  componentDidMount: ->
    node = @refs.name.getDOMNode()
    node.focus()
    node.select()

  render: ->

    Dialog {icon: 'team', title: 'Create a team', closeDialog: @props.closeDialog},
      FieldGroup {},
        Field {label: 'Name', note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team'},
          input {ref: 'name', value: @state.name, onChange: @onNameChanged}
        Field {label: 'Members'},
          MembershipEditor {}
      DialogButtons {},
        Button {text: 'Create Team', disabled: !@isValid(), onClick: @createTeam}
        Button {text: 'Cancel',      onClick: @props.closeDialog}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {dirty: true, name: event.target.value}

  createTeam: ->
    @publish new UserCreatedTeamEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateTeamDialog
