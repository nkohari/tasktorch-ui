#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
CachedState       = require 'ui/framework/mixins/CachedState'
Button            = React.createFactory(require 'ui/common/Button')
Dialog            = React.createFactory(require 'ui/common/Dialog')
DialogFooter      = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger     = React.createFactory(require 'ui/common/DialogTrigger')
Field             = React.createFactory(require 'ui/common/Field')
OrgMembershipList = React.createFactory(require 'ui/common/OrgMembershipList')
{div}             = React.DOM
#--------------------------------------------------------------------------------

OrgMembersDialog = React.createClass {

  displayName: 'OrgMembersDialog'

  props:
    orgid:       PropTypes.id
    closeDialog: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) ->
    org         = cache('orgs').get(@props.orgid)
    memberships = cache('membershipsByOrg').get(@props.orgid)
    {org, memberships}

  render: ->

    footer = DialogFooter {
      left: DialogTrigger {name: 'SendInvites', orgid: @props.orgid},
        Button {icon: 'invite', text: 'Invite others'}
      right: Button {text: 'Done', onClick: @props.closeDialog}
    }

    Dialog {icon: 'org', height: 600, title: "Members of #{@state.org?.name}", footer, closeDialog: @props.closeDialog},
      Field {hint: 'org-memberships', expand: true},
        OrgMembershipList {org: @state.org, memberships: @state.memberships}

}

module.exports = OrgMembersDialog
