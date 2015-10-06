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
DialogFooter                   = React.createFactory(require 'ui/common/DialogFooter')
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
    if team? and members?
      leaders = _.map team.leaders, (id) ->
        _.find members, (u) -> u.id == id
    {members, leaders, team}

  componentDidMount: ->
    @refs.members.focus()

  render: ->

    footer = DialogFooter {
      right: Button {text: 'Done', onClick: @props.closeDialog}
    }

    Dialog {icon: 'team', height: 600, title: "Members of #{@state.team?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Members', expand: true},
        MembershipEditor {
          ref: 'members'
          members: @state.members
          leaders: @state.leaders
          @addLeader
          @addMember
          @removeLeader
          @removeMember
        }

  addMember: (user) ->
    return if _.any(@state.members, (u) -> u.id == user.id)
    members = @state.members.concat(user)
    @setState {members}
    @publish new UserAddedMemberToTeamEvent(@props.teamid, user.id)

  removeMember: (user) ->
    members = _.filter @state.members, (u) -> u.id != user.id
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {members, leaders}
    @publish new UserRemovedMemberFromTeamEvent(@props.teamid, user.id)

  addLeader: (user) ->
    return if _.any(@state.leaders, (u) -> u.id == user.id)
    leaders = @state.leaders.concat(user)
    @setState {leaders}
    @publish new UserAddedLeaderToTeamEvent(@props.teamid, user.id)

  removeLeader: (user) ->
    leaders = _.filter @state.leaders, (u) -> u.id != user.id
    @setState {leaders}
    @publish new UserRemovedLeaderFromTeamEvent(@props.teamid, user.id)

}

module.exports = TeamMembersDialog
