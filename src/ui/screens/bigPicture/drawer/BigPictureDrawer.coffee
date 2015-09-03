#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
CachedState       = require 'ui/framework/mixins/CachedState'
ShellContext      = require 'ui/framework/mixins/ShellContext'
Drawer            = React.createFactory(require 'ui/common/Drawer')
GoalDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/GoalDrawerSection')
KindDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerSection')
TeamDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamDrawerSection')
{div}             = React.DOM
#--------------------------------------------------------------------------------

BigPictureDrawer = React.createClass {

  displayName: 'BigPictureDrawer'

  mixins: [CachedState, ShellContext]

  getCachedState: (cache) ->
    org = @getCurrentOrg()
    return {
      goals: cache('goalsByOrg').get(org.id)
      kinds: cache('kindsByOrg').get(org.id)
      teams: cache('teamsByOrg').get(org.id)
    }

  render: ->

    Drawer {className: 'big-picture'},
      GoalDrawerSection {goals: @state.goals}
      TeamDrawerSection {teams: @state.teams}
      KindDrawerSection {kinds: @state.kinds}

}

module.exports = BigPictureDrawer
