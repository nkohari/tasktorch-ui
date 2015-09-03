#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
DrawerSection   = React.createFactory(require 'ui/common/DrawerSection')
TeamDrawerItem  = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamDrawerItem')
#--------------------------------------------------------------------------------

TeamDrawerSection = React.createClass {

  displayName: 'TeamDrawerSection'

  propTypes:
    teams: PropTypes.arrayOf(PropTypes.Team)

  render: ->

    items = _.map @props.teams, (team) =>
      TeamDrawerItem {key: team.id, team}

    DrawerSection {className: 'team-section', title: 'By Team'},
      items

}

module.exports = TeamDrawerSection
