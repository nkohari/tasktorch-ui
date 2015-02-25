React                = require 'react'
CachedState          = require 'ui/framework/mixins/CachedState'
PropTypes            = require 'ui/framework/PropTypes'
Frame                = React.createFactory(require 'ui/common/Frame')
FollowingSidebarItem = React.createFactory(require 'ui/screens/workspace/sidebar/FollowingSidebarItem')
StackBrowser         = React.createFactory(require 'ui/screens/workspace/sidebar/StackBrowser')

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    teams:  cache('myTeams').get()
    stacks: cache('myStacks').get()
  }

  isReady: ->
    @state.teams? and @state.stacks?

  render: ->

    Frame {@isReady, className: 'workspace sidebar'},
      FollowingSidebarItem {currentUser: @props.currentUser}
      StackBrowser         {currentUser: @props.currentUser, stacks: @state.stacks, teams: @state.teams}

}

module.exports = WorkspaceSidebar
