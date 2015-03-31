React                = require 'react'
UserRenamedTeamEvent = require 'events/ui/UserRenamedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
FieldGroup           = React.createFactory(require 'ui/common/FieldGroup')
{div, input}         = React.DOM

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
    node = @refs.name.getDOMNode()
    node.focus()
    node.select()

  render: ->

    Dialog {icon: 'team', title: "Rename #{@props.team.name}", closeDialog: @props.closeDialog},
      FieldGroup {},
        Field {label: 'Name', note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team'},
          input {ref: 'name', value: @state.name, onChange: @onNameChanged}
      DialogButtons {},
        Button {text: 'Rename Team', disabled: !@isValid(), onClick: @renameTeam}
        Button {text: 'Cancel',      onClick: @props.closeDialog}

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
