React                = require 'react'
UserRenamedTeamEvent = require 'events/ui/UserRenamedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Field                = React.createFactory(require 'ui/common/Field')
FieldGroup           = React.createFactory(require 'ui/common/FieldGroup')
Input                = React.createFactory(require 'ui/common/Input')

RenameTeamDialog = React.createClass {

  displayName: 'RenameTeamDialog'

  props:
    teamid:      PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    team = cache('teams').get(@props.teamid)
    name = team.name if team? and not @state?
    {name, team}

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Rename Team', onClick: @renameTeam, disabled: !@isValid()}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'team', title: "Rename #{@state.team?.name}", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name'},
        Input {ref: 'name', placeholder: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  renameTeam: ->
    unless @state.name == @state.team.name
      @publish new UserRenamedTeamEvent(@props.teamid, @state.name)
    @props.closeDialog()

}

module.exports = RenameTeamDialog
