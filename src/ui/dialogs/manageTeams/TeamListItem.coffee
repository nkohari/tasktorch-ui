#--------------------------------------------------------------------------------
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
CachedState     = require 'ui/framework/mixins/CachedState'
Avatar          = React.createFactory(require 'ui/common/Avatar')
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
TeamContextMenu = React.createFactory(require 'ui/overlays/TeamContextMenu')
{ul, li, div}   = React.DOM
#--------------------------------------------------------------------------------
require './TeamListItem.styl'
#--------------------------------------------------------------------------------

MAX_MEMBERS = 5

TeamListItem = React.createClass {

  displayEmail: 'TeamListItem'

  propTypes:
    team: PropTypes.Team

  mixins: [CachedState]

  getCachedState: (cache) -> {
    members: cache('membersByTeam').get(@props.team.id)
  }

  render: ->

    numberOfMembers = @state.members?.length

    if numberOfMembers == 0
      members = li {className: 'text'},
        "No members"
    else
      members = _.map _.take(@state.members, MAX_MEMBERS), (member) =>
        li {className: 'team-member'},
          Avatar {user: member, size: 16}
      if numberOfMembers > MAX_MEMBERS
        etc = li {className: 'text'},
          "and #{numberOfMembers - MAX_MEMBERS} others"

    li {className: 'team-list-item', onClick: @showContextMenu},
      div {className: 'team-info'},
        div {className: 'team-name'},
          Icon {name: 'team'}
          @props.team.name
        ul {className: 'team-members'},
          members
          etc
      OverlayTrigger {ref: 'trigger', overlay: TeamContextMenu {teamid: @props.team.id}},
        Icon {name: 'trigger'}

  showContextMenu: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @refs.trigger.showOverlay()

}

module.exports = TeamListItem
