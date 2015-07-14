#--------------------------------------------------------------------------------
React                = require 'react'
Router               = require 'react-router'
autokey              = require 'common/util/autokey'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
ShellContext         = require 'ui/framework/mixins/ShellContext'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM
#--------------------------------------------------------------------------------

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  mixins: [CachedState, ShellContext, Router.Navigation]

  getCachedState: (cache) -> {
    isMemberOfMultipleOrgs: cache('myOrgs').get()?.length > 1
  }

  render: ->

    currentOrg = @getCurrentOrg()

    commonItems = [
      DialogTrigger {name: 'Help'},
        Icon {name: 'help'}
        'Help'
    ]

    leaderItems = [
      ContextMenuSeparator {}
      DialogTrigger {name: 'SendInvites', orgid: currentOrg.id},
        Icon {name: 'invite'}
        'Invite others'
      DialogTrigger {name: 'CreateTeam', orgid: currentOrg.id},
        Icon {name: 'team'}
        'Create a team'
      DialogTrigger {name: 'OrgMembers', orgid: currentOrg.id},
        Icon {name: 'org'}
        'Manage members'
      DialogTrigger {name: 'ManageKinds', orgid: currentOrg.id},
        Icon {name: 'kind'}
        'Manage card kinds'
    ]

    switchItems = [
      ContextMenuSeparator {}
      a {onClick: @switchOrgsClicked},
        Icon {name: 'switch'}
        'Switch organizations'
    ]

    items = autokey [
      commonItems
      leaderItems # TODO: Add flag when org leaders are shaped up
      switchItems if @state.isMemberOfMultipleOrgs
    ]

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      items

  switchOrgsClicked: ->
    @transitionTo('select-org')

}

module.exports = OrgContextMenu
