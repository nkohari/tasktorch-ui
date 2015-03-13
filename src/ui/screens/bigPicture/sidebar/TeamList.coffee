_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
Frame           = React.createFactory(require 'ui/common/Frame')
List            = React.createFactory(require 'ui/common/List')
TeamSidebarItem = React.createFactory(require 'ui/screens/bigPicture/sidebar/TeamSidebarItem')

TeamList = React.createClass {

  displayName: 'TeamList'

  propTypes:
    title: PropTypes.string
    teams: PropTypes.arrayOf(PropTypes.Team)

  render: ->

    items = _.map @props.teams, (team) =>
      TeamSidebarItem {key: team.id, team}

    Frame {className: 'teams group'},
      Frame {className: 'header'}, @props.title
      List {}, items

}

module.exports = TeamList
