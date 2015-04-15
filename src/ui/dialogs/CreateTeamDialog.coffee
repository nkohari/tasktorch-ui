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
    purpose: ''
  }

  render: ->

    completeButton = Button {text: 'Create Team', disabled: !@isComplete(), onClick: @createTeam}

    Wizard {icon: 'team', title: 'Create a team', completeButton, closeDialog: @props.closeDialog},
      CreateTeamDialogNamePage    {title: 'Name and Purpose', name: @state.name, purpose: @state.purpose, onChange: @onPageStateChanged}
      CreateTeamDialogMembersPage {title: 'Membership', members: @state.memebrs, onChange: @onPageStateChanged}

  isComplete: ->
    @state.name?.length > 0

  onPageStateChanged: (state) ->
    @setState(state)

  createTeam: ->
    @publish new UserCreatedTeamEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateTeamDialog
