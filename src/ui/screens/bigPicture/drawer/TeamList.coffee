_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
TeamDrawerItem  = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamDrawerItem')
{div, span, ul} = React.DOM

TeamList = React.createClass {

  displayName: 'TeamList'

  propTypes:
    title: PropTypes.string
    teams: PropTypes.arrayOf(PropTypes.Team)

  render: ->

    items = _.map @props.teams, (team) =>
      TeamDrawerItem {key: team.id, team}

    div {className: 'teams group'},
      div {className: 'header'},
        span {className: 'title'}, @props.title
      ul {}, items

}

module.exports = TeamList
