_                  = require 'lodash'
React              = require 'react/addons'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
TeamPanelColumn    = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanelColumn')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

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

    div {className: 'big-picture panel'},
      PanelHeader {panelid: @props.id, icon: 'team'},
        @state.team?.name
      div {className: 'content'}, columns
      div {className: 'footer'}

}

module.exports = TeamPanel
