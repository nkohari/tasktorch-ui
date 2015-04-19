_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
QueueColumn        = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueColumn')
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
      QueueColumn {key: user.id, user}

    div {className: 'big-picture panel'},
      PanelHeader {panelid: @props.id, icon: 'team'},
        @state.team?.name
      div {className: 'content'}, columns
      div {className: 'footer'}

}

module.exports = TeamPanel
