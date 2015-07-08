#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
UserCreatedTeamEvent = require 'events/ui/UserCreatedTeamEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
ShellContext         = require 'ui/framework/mixins/ShellContext'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter        = React.createFactory(require 'ui/common/DialogFooter')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')
MembershipEditor     = React.createFactory(require 'ui/common/MembershipEditor')
#--------------------------------------------------------------------------------

CreateTeamDialog = React.createClass {

  displayName: 'CreateTeamDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor, ShellContext]

  getInitialState: ->
    currentUser = @getCurrentUser()
    {leaders: [currentUser], members: [currentUser]}

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Create Team', onClick: @createTeam, disabled: !@isComplete()}
        Button {text: 'Cancel',      onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'team', width: 700, height: 560, className: 'create-team', title: 'Create a Team', footer, closeDialog: @props.closeDialog},
      Field {label: 'Name'},
        Input {ref: 'name', placeholder: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team', value: @state.name, onChange: @setName}
      Field {label: 'Purpose'},
        Input {ref: 'purpose', placeholder: 'ex. Product Development, Customer Happiness, World Domination', value: @state.purpose, onChange: @setPurpose}
      Field {label: 'Members', expand: true},
        MembershipEditor {
          leaders: @state.leaders
          members: @state.members
          @addLeader
          @addMember
          @removeLeader
          @removeMember
        }

  isComplete: ->
    @state.name?.length > 0 and @state.members?.length > 0 and @state.leaders?.length > 0

  setName: (event) ->
    @setState {name: event.target.value}

  setPurpose: (event) ->
    @setState {purpose: event.target.value}

  addMember: (user) ->
    members = @state.members.concat(user)
    @setState {members}

  removeMember: (user) ->
    members = _.filter @state.members, (u) -> u.id != user.id
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {members, leaders}

  addLeader: (user) ->
    leaders = @state.leaders.concat(user)
    @setState {leaders}

  removeLeader: (user) ->
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {leaders}

  createTeam: ->
    members = _.pluck(@state.members, 'id')
    leaders = _.pluck(@state.leaders, 'id')
    @publish new UserCreatedTeamEvent(@state.name, @state.purpose, members, leaders)
    @props.closeDialog()

}

module.exports = CreateTeamDialog
