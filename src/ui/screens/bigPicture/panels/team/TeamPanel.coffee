#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
mergeProps         = require 'common/util/mergeProps'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
OverlayTrigger     = React.createFactory(require 'ui/common/OverlayTrigger')
Panel              = React.createFactory(require 'ui/common/Panel')
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
TeamContextMenu    = React.createFactory(require 'ui/overlays/TeamContextMenu')
TeamPanelColumn    = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanelColumn')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
#--------------------------------------------------------------------------------

TeamPanel = React.createClass {

  displayName: 'TeamPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) ->
    team  = cache('teams').get(@props.id)
    users = cache('membersByTeam').get(@props.id)
    {team, users}

  render: ->

    columns = _.map @state.users, (user) =>
      TeamPanelColumn {key: user.id, team: @state.team, user}

    props = mergeProps _.omit(@props, 'type'), {
      className: 'big-picture'
    }

    if @state.kind?
      controls = OverlayTrigger {ref: 'trigger', overlay: TeamContextMenu {teamid: @state.team.id}},
        Icon {name: 'trigger'}    

    Panel props,
      PanelHeader {panelid: @props.id, icon: 'team'},
        @state.team?.name
      div {className: 'content'}, columns
      div {className: 'footer'}

}

module.exports = TeamPanel
