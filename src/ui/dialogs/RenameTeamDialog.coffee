React                = require 'react'
UserRenamedTeamEvent = require 'events/ui/UserRenamedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogField          = React.createFactory(require 'ui/common/DialogField')
{div, label, input}  = React.DOM

RenameTeamDialog = React.createClass {

  displayName: 'RenameTeamDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    value: @props.team.name
    dirty: false
  }

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    Dialog {icon: 'team', title: "Rename #{@props.team.name}", closeDialog: @props.closeDialog},
      DialogField {ref: 'name', name: 'Name', value: @state.value, note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', @onChange}
      div {className: 'dialog-buttons'},
        Button {text: 'Rename Team', disabled: !@state.dirty, onClick: @renameTeam}
        Button {text: 'Cancel',      onClick: @props.closeDialog}

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}

  renameTeam: ->
    @publish new UserRenamedTeamEvent(@props.team.id, @state.value)
    @props.closeDialog()

}

module.exports = RenameTeamDialog
