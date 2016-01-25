#--------------------------------------------------------------------------------
React                = require 'react'
Router               = require 'react-router'
autokey              = require 'common/util/autokey'
MembershipLevel      = require 'data/enums/MembershipLevel'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
IdentityContext      = require 'ui/framework/mixins/IdentityContext'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a, li}              = React.DOM
#--------------------------------------------------------------------------------

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  mixins: [CachedState, IdentityContext, Router.History]

  getCachedState: (cache) ->
    memberships  = cache('myMemberships').get()
    if memberships?
      isMemberOfMultipleOrgs = memberships.length > 1
      currentOrgMembership = _.find memberships, (m) => m.org == @getCurrentOrg().id
      isLeaderOfCurrentOrg = currentOrgMembership.level == MembershipLevel.Leader
    {isMemberOfMultipleOrgs, isLeaderOfCurrentOrg}

  render: ->

    currentOrg = @getCurrentOrg()

    leaderItems = [
      DialogTrigger {name: 'OrgMembers', orgid: currentOrg.id},
        Icon {name: 'org'}
        'Members'
      DialogTrigger {name: 'ManageAccount', orgid: currentOrg.id},
        Icon {name: 'billing'}
        'Account Details'
      ContextMenuSeparator {}
    ]

    commonItems = [
      DialogTrigger {name: 'ManageTeams', orgid: currentOrg.id},
        Icon {name: 'team'}
        'Teams'
      DialogTrigger {name: 'ManageGoals', orgid: currentOrg.id},
        Icon {name: 'goal'}
        'Goals'
      DialogTrigger {name: 'ManageKinds', orgid: currentOrg.id},
        Icon {name: 'kind'}
        'Card Kinds'
    ]

    switchItems = [
      ContextMenuSeparator {}
      a {onClick: @switchOrgsClicked},
        Icon {name: 'switch'}
        'Switch Organizations'
    ]

    items = autokey [
      DialogTrigger {name: 'Help'},
        Icon {name: 'help'}
        'Help'
      ContextMenuSeparator {}
      leaderItems if @state.isLeaderOfCurrentOrg
      commonItems
      switchItems if @state.isMemberOfMultipleOrgs
    ]

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      items

  switchOrgsClicked: ->
    @history.pushState(null, '/orgs')

}

module.exports = OrgContextMenu
