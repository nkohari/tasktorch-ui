#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
MembershipStatus = require 'data/enums/MembershipStatus'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
OrgMembership    = React.createFactory(require 'ui/common/OrgMembership')
{ul, li}         = React.DOM
#--------------------------------------------------------------------------------
require './OrgMembershipList.styl'
#--------------------------------------------------------------------------------

OrgMembershipList = React.createClass {

  displayName: 'OrgMembershipList'

  propTypes:
    org:         PropTypes.Org
    memberships: PropTypes.arrayOf(PropTypes.Membership)

  mixins: [CachedState]

  getCachedState: (cache) ->
    {users: cache('usersByOrg').get(@props.org.id)}

  render: ->

    usernames   = _.fromPairs _.map @state.users, (u) -> [u.id, u.name]
    memberships = _.groupBy(@props.memberships, 'status')

    activeMemberships   = _.sortBy memberships[MembershipStatus.Normal],   (m) -> usernames[m.user]
    disabledMemberships = _.sortBy memberships[MembershipStatus.Disabled], (m) -> usernames[m.user]

    ul {className: 'org-membership-list'},
      _.map(activeMemberships,   @renderMembership)
      _.map(disabledMemberships, @renderMembership)

  renderMembership: (membership) ->
    li {},
      OrgMembership {key: membership.id, membership}

}

module.exports = OrgMembershipList
