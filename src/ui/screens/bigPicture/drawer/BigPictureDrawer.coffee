#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
ShellContext = require 'ui/framework/mixins/ShellContext'
Drawer       = React.createFactory(require 'ui/common/Drawer')
GoalList     = React.createFactory(require 'ui/screens/bigPicture/drawer/GoalList')
KindList     = React.createFactory(require 'ui/screens/bigPicture/drawer/KindList')
TeamList     = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamList')
{div}        = React.DOM
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
      GoalList {goals: @state.goals}
      TeamList {teams: @state.teams}
      KindList {kinds: @state.kinds}

}

module.exports = BigPictureDrawer
