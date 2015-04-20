_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Actor            = require 'ui/framework/mixins/Actor'
CachedState      = require 'ui/framework/mixins/CachedState'
Button           = React.createFactory(require 'ui/common/Button')
Dialog           = React.createFactory(require 'ui/common/Dialog')
DialogButtons    = React.createFactory(require 'ui/common/DialogButtons')
Field            = React.createFactory(require 'ui/common/Field')
MembershipEditor = React.createFactory(require 'ui/common/MembershipEditor')
{div}            = React.DOM

TeamMembersDialog = React.createClass {

  displayName: 'TeamMembersDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    members: cache('users').getAll(@props.team.members)
    leaders: cache('users').getAll(@props.team.leaders)
  }

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Done', onClick: @props.closeDialog}

    Dialog {icon: 'team', height: 560, title: "#{@props.team.name} Membership", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Members'},
        MembershipEditor {
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

}

module.exports = TeamMembersDialog
