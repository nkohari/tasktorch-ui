React                = require 'react'
UserRenamedTeamEvent = require 'events/ui/UserRenamedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
FieldGroup           = React.createFactory(require 'ui/common/FieldGroup')
Input                = React.createFactory(require 'ui/common/Input')

RenameTeamDialog = React.createClass {

  displayName: 'RenameTeamDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    name:     @props.team.name
    previous: @props.team.name
    dirty:    false
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Rename Team', onClick: @renameTeam, disabled: !@isValid()}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'team', title: "Rename #{@props.team.name}", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name', note: 'What would you like to name the team?'},
        Input {ref: 'name', placeholder: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {
      name: event.target.value
      dirty: event.target.value != @state.previous
    }

  renameTeam: ->
    unless @state.name == @state.previous
      @publish new UserRenamedTeamEvent(@props.team.id, @state.name)
    @props.closeDialog()

}

module.exports = RenameTeamDialog
