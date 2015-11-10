#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
MembershipStatus      = require 'data/enums/MembershipStatus'
PropTypes             = require 'ui/framework/PropTypes'
CachedState           = require 'ui/framework/mixins/CachedState'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Avatar                = React.createFactory(require 'ui/common/Avatar')
Button                = React.createFactory(require 'ui/common/Button')
Icon                  = React.createFactory(require 'ui/common/Icon')
Time                  = React.createFactory(require 'ui/common/Time')
OverlayTrigger        = React.createFactory(require 'ui/common/OverlayTrigger')
MembershipContextMenu = React.createFactory(require 'ui/overlays/MembershipContextMenu')
{div, span}           = React.DOM
#--------------------------------------------------------------------------------
require './OrgMembership.styl'
#--------------------------------------------------------------------------------

OrgMembership = React.createClass {

  displayName: 'OrgMembership'

  propTypes:
    membership: PropTypes.Membership

  mixins: [CachedState, IdentityContext]

  getInitialState: ->
    {expanded: false}

  getCachedState: (cache) ->
    {user: cache('users').get(@props.membership.user)}

  render: ->

    classes = classSet [
      'org-membership'
      @props.membership.status.toLowerCase()
    ]

    unless @props.membership.user == @getCurrentUser().id
      trigger = OverlayTrigger {overlay: MembershipContextMenu {membership: @props.membership}},
        Icon {name: 'trigger'}
    else
      currentUserMarker = span {className: 'org-membership-user-me'}, " (You)"

    if @props.membership.status == MembershipStatus.Disabled
      badge = 'Deactivated'
    else
      badge = @props.membership.level

    div {className: classes},
      div {className: 'org-membership-info'},
        Avatar {size: 32, user: @state.user}
        div {className: 'org-membership-user'},
          div {},
            span {className: 'org-membership-user-name'}, @state.user?.name
            currentUserMarker
            span {className: 'org-membership-user-username'}, " (@#{@state.user?.username})"
          div {className: 'org-membership-since'},
            "Member since "
            Time {time: @props.membership.created, format: 'MM/YYYY'}
        div {},
          span {className: 'org-membership-level'}, badge
        div {className: 'org-membership-menu'},
          trigger

}

module.exports = OrgMembership
