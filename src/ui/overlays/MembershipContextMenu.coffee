#--------------------------------------------------------------------------------
_                                = require 'lodash'
React                            = require 'react'
PropTypes                        = require 'ui/framework/PropTypes'
MembershipLevel                  = require 'data/enums/MembershipLevel'
MembershipStatus                 = require 'data/enums/MembershipStatus'
UserChangedMembershipLevelEvent  = require 'events/ui/UserChangedMembershipLevelEvent'
UserChangedMembershipStatusEvent = require 'events/ui/UserChangedMembershipStatusEvent'
Actor                            = require 'ui/framework/mixins/Actor'
ContextMenu                      = React.createFactory(require 'ui/common/ContextMenu')
Icon                             = React.createFactory(require 'ui/common/Icon')
{a}                              = React.DOM
#--------------------------------------------------------------------------------

MembershipContextMenu = React.createClass {

  displayName: 'MembershipContextMenu'

  propTypes:
    membership:  PropTypes.Membership
    hideOverlay: PropTypes.func

  mixins: [Actor]

  render: ->

    if @props.membership.status == MembershipStatus.Disabled
      @renderDisabled()
    else
      @renderNormal()

  renderNormal: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      a {onClick: @changeLevel},
        "Make #{if @props.membership.level == MembershipLevel.Member then 'Leader' else 'Member'}"
      a {onClick: @changeStatus},
        "Deactivate User"

  renderDisabled: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      a {onClick: @changeStatus},
        "Reactivate User"

  changeLevel: ->

    if @props.membership.level == MembershipLevel.Member
      level = MembershipLevel.Leader
    else
      level = MembershipLevel.Member

    @publish new UserChangedMembershipLevelEvent(@props.membership.id, level)

  changeStatus: ->

    if @props.membership.status == MembershipStatus.Disabled
      status = MembershipStatus.Normal
    else
      status = MembershipStatus.Disabled

    @publish new UserChangedMembershipStatusEvent(@props.membership.id, status)

}

module.exports = MembershipContextMenu
