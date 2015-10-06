#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
PanelContext         = require 'ui/framework/mixins/PanelContext'
UserPanelSpec        = require 'ui/framework/panels/UserPanelSpec'
Avatar               = React.createFactory(require 'ui/common/Avatar')
{div, ul, li}        = React.DOM
#--------------------------------------------------------------------------------
require './UserTeamRow.styl'
#--------------------------------------------------------------------------------

UserTeamRow = React.createClass {

  displayName: 'UserTeamRow'

  propTypes:
    team: PropTypes.Team

  mixins: [Actor, CachedState, PanelContext]

  getCachedState: (cache) -> {
    members: cache('membersByTeam').get(@props.team.id)
  }

  render: ->

    members = _.map @state.members, (member) =>
      li {className: 'user-team-member'},
        Avatar {user: member, onClick: @openUserPanel.bind(this, member)}

    div {className: 'user-team'},
      div {className: 'user-team-name'},
        @props.team.name
      ul {className: 'user-team-members'}, members

  openUserPanel: (user) ->
    @publish new UserOpenedPanelEvent(new UserPanelSpec(user.id), {after: @getCurrentPanel().id})

}

module.exports = UserTeamRow
