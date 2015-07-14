#--------------------------------------------------------------------------------
_                             = require 'lodash'
React                         = require 'react'
UserAddedLeaderToOrgEvent     = require 'events/ui/UserAddedLeaderToOrgEvent'
UserRemovedLeaderFromOrgEvent = require 'events/ui/UserRemovedLeaderFromOrgEvent'
UserRemovedMemberFromOrgEvent = require 'events/ui/UserRemovedMemberFromOrgEvent'
PropTypes                     = require 'ui/framework/PropTypes'
Actor                         = require 'ui/framework/mixins/Actor'
CachedState                   = require 'ui/framework/mixins/CachedState'
Button                        = React.createFactory(require 'ui/common/Button')
Dialog                        = React.createFactory(require 'ui/common/Dialog')
DialogFooter                  = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger                 = React.createFactory(require 'ui/common/DialogTrigger')
Field                         = React.createFactory(require 'ui/common/Field')
MembershipEditor              = React.createFactory(require 'ui/common/MembershipEditor')
{div}                         = React.DOM
#--------------------------------------------------------------------------------

OrgMembersDialog = React.createClass {

  displayName: 'OrgMembersDialog'

  props:
    orgid:       PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    org     = cache('orgs').get(@props.orgid)
    members = cache('usersByOrg').get(@props.orgid)
    leaders = org.leaders if org?
    {leaders, members, org}

  componentDidMount: ->
    @refs.members.focus()

  render: ->

    footer = DialogFooter {
      left: DialogTrigger {name: 'SendInvites', orgid: @props.orgid},
        Button {icon: 'invite', text: 'Invite others'}
      right: Button {text: 'Done', onClick: @props.closeDialog}
    }

    Dialog {icon: 'org', height: 600, title: "Members of #{@state.org?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Members', expand: true},
        MembershipEditor {
          ref: 'members'
          allowEditSelf: false
          members: @state.members
          leaders: @state.leaders
          @addLeader
          @removeLeader
          @removeMember
        }

  removeMember: (user) ->
    members = _.filter(@state.members, (u) -> u.id != user.id)
    leaders = _.without(@state.leaders, user.id)
    @setState {members, leaders}
    @publish new UserRemovedMemberFromOrgEvent(@props.orgid, user.id)

  addLeader: (user) ->
    leaders = @state.leaders.concat(user.id)
    @setState {leaders}
    @publish new UserAddedLeaderToOrgEvent(@props.orgid, user.id)

  removeLeader: (user) ->
    leaders = _.without(@state.leaders, user.id)
    @setState {leaders}
    @publish new UserRemovedLeaderFromOrgEvent(@props.orgid, user.id)

}

module.exports = OrgMembersDialog
