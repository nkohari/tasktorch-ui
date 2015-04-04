React                    = require 'react'
UserCreatedTeamEvent     = require 'events/ui/UserCreatedTeamEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
Button                   = React.createFactory(require 'ui/common/Button')
Wizard                   = React.createFactory(require 'ui/common/Wizard')
CreateTeamDialogNamePage = React.createFactory(require 'ui/dialogs/CreateTeamDialogNamePage')
CreateTeamDialogMembersPage = React.createFactory(require 'ui/dialogs/CreateTeamDialogMembersPage')

CreateTeamDialog = React.createClass {

  displayName: 'CreateTeamDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    name: ''
  }

  render: ->

    completeButton = Button {text: 'Create Team', disabled: !@isComplete(), onClick: @createTeam}

    Wizard {icon: 'team', title: 'Create a team', completeButton, closeDialog: @props.closeDialog},
      CreateTeamDialogNamePage    {title: 'Name your team', name: @state.name, onChange: @onPageStateChanged}
      CreateTeamDialogMembersPage {title: 'Select team members', members: @state.memebrs, onChange: @onPageStateChanged}

  isComplete: ->
    @state.name?.length > 0

  onPageStateChanged: (state) ->
    @setState(state)

  createTeam: ->
    @publish new UserCreatedTeamEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateTeamDialog
