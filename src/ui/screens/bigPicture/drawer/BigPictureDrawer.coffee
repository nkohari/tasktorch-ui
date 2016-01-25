#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
GoalStatus        = require 'data/enums/GoalStatus'
KindStatus        = require 'data/enums/KindStatus'
PropTypes         = require 'ui/framework/PropTypes'
CachedState       = require 'ui/framework/mixins/CachedState'
IdentityContext   = require 'ui/framework/mixins/IdentityContext'
Drawer            = React.createFactory(require 'ui/common/Drawer')
GoalDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/GoalDrawerSection')
KindDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/KindDrawerSection')
TeamDrawerSection = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamDrawerSection')
{div}             = React.DOM
#--------------------------------------------------------------------------------

BigPictureDrawer = React.createClass {

  displayName: 'BigPictureDrawer'

  mixins: [CachedState, IdentityContext]

  getCachedState: (cache) ->
    org = @getCurrentOrg()
    return {
      goals: cache('goalsByOrg').get(org.id)
      kinds: cache('kindsByOrg').get(org.id)
      teams: cache('teamsByOrg').get(org.id)
    }

  render: ->

    goals = _.filter @state.goals, (g) -> g.status == GoalStatus.Normal
    kinds = _.filter @state.kinds, (k) -> k.status == KindStatus.Normal

    Drawer {className: 'big-picture'},
      GoalDrawerSection {goals: goals}
      TeamDrawerSection {teams: @state.teams}
      KindDrawerSection {kinds: kinds}

}

module.exports = BigPictureDrawer
