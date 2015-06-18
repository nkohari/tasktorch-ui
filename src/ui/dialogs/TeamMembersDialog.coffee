#--------------------------------------------------------------------------------
_                              = require 'lodash'
React                          = require 'react'
UserAddedLeaderToTeamEvent     = require 'events/ui/UserAddedLeaderToTeamEvent'
UserAddedMemberToTeamEvent     = require 'events/ui/UserAddedMemberToTeamEvent'
UserRemovedLeaderFromTeamEvent = require 'events/ui/UserRemovedLeaderFromTeamEvent'
UserRemovedMemberFromTeamEvent = require 'events/ui/UserRemovedMemberFromTeamEvent'
PropTypes                      = require 'ui/framework/PropTypes'
Actor                          = require 'ui/framework/mixins/Actor'
CachedState                    = require 'ui/framework/mixins/CachedState'
Button                         = React.createFactory(require 'ui/common/Button')
Dialog                         = React.createFactory(require 'ui/common/Dialog')
DialogButtons                  = React.createFactory(require 'ui/common/DialogButtons')
Field                          = React.createFactory(require 'ui/common/Field')
MembershipEditor               = React.createFactory(require 'ui/common/MembershipEditor')
{div}                          = React.DOM
#--------------------------------------------------------------------------------

TeamMembersDialog = React.createClass {

  displayName: 'TeamMembersDialog'

  props:
    teamid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    team    = cache('teams').get(@props.teamid)
    members = cache('membersByTeam').get(@props.teamid)
    leaders = cache('users').getAll(team.leaders) if team?
    {leaders, members, team}

  componentDidMount: ->
    @refs.members.focus()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Done', onClick: @props.closeDialog}

    Dialog {icon: 'team', height: 440, title: "#{@state.team?.name} Membership", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Members', expand: true},
        MembershipEditor {
          ref: 'members'
          leaders: @state.leaders
          members: @state.members
          @addLeader
          @addMember
          @removeLeader
          @removeMember
        }

  addMember: (user) ->
    members = @state.members.concat(user)
    @setState {members}
    @publish new UserAddedMemberToTeamEvent(@props.teamid, user.id)

  removeMember: (user) ->
    members = _.filter @state.members, (u) -> u.id != user.id
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {members, leaders}
    @publish new UserRemovedMemberFromTeamEvent(@props.teamid, user.id)

  addLeader: (user) ->
    leaders = @state.leaders.concat(user)
    @setState {leaders}
    @publish new UserAddedLeaderToTeamEvent(@props.teamid, user.id)

  removeLeader: (user) ->
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {leaders}
    @publish new UserRemovedLeaderFromTeamEvent(@props.teamid, user.id)

}

module.exports = TeamMembersDialog
