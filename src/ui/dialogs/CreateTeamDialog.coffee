React                = require 'react'
UserCreatedTeamEvent = require 'events/ui/UserCreatedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogField          = React.createFactory(require 'ui/common/DialogField')
{div}                = React.DOM

RenameTeamDialog = React.createClass {

  displayName: 'RenameTeamDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    dirty: false
    value: ''
  }

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    Dialog {icon: 'team', title: 'Create Team', closeDialog: @props.closeDialog},
      DialogField {ref: 'name', name: 'Name', note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', @onChange}
      div {className: 'dialog-buttons'},
        Button {text: 'Create Team', disabled: !@state.dirty, onClick: @renameTeam}
        Button {text: 'Cancel',      onClick: @props.closeDialog}

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}

  renameTeam: ->
    @publish new UserCreatedTeamEvent(@state.value)
    @props.closeDialog()

}

module.exports = RenameTeamDialog
