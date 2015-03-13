_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Frame              = React.createFactory(require 'ui/common/Frame')
Icon               = React.createFactory(require 'ui/common/Icon')
QueueColumn        = React.createFactory(require 'ui/screens/bigPicture/QueueColumn')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

TeamPanel = React.createClass {

  displayName: 'TeamPanel'

  propTypes:
    teamid: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) ->
    team  = cache('teams').get(@props.teamid)
    users = cache('membersByTeam').get(@props.teamid)
    {team, users}

  isReady: ->
    @state.team? and @state.users?

  render: ->

    items = _.map @state.users, (user) =>
      QueueColumn {key: user.id, user}

    Frame {@isReady, className: 'team panel'},
      div {className: 'header'},
        Icon {name: 'team'}
        @state.team?.name
      div {className: 'columns'}, items
      div {className: 'footer'}

}

module.exports = TeamPanel
