_                   = require 'lodash'
React               = require 'react'
CachedState         = require 'ui/framework/mixins/CachedState'
PropTypes           = require 'ui/framework/PropTypes'
Frame               = React.createFactory(require 'ui/common/Frame')
FollowingDrawerItem = React.createFactory(require 'ui/screens/workspace/drawer/FollowingDrawerItem')
MyWorkDrawerSection = React.createFactory(require 'ui/screens/workspace/drawer/MyWorkDrawerSection')
TeamDrawerSection   = React.createFactory(require 'ui/screens/workspace/drawer/TeamDrawerSection')

WorkspaceDrawer = React.createClass {

  displayName: 'WorkspaceDrawer'

  mixins: [CachedState]

  getCachedState: (cache) -> {
    teams:  cache('myTeams').get()
    stacks: cache('myStacks').get()
  }

  render: ->

    teamSections = _.map @state.teams, (team) =>
      TeamDrawerSection {key: team.id, team}

    Frame {className: 'workspace drawer'},
      FollowingDrawerItem {}
      MyWorkDrawerSection {stacks: @state.stacks}
      teamSections

}

module.exports = WorkspaceDrawer
