#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
classSet            = require 'common/util/classSet'
PropTypes           = require 'ui/framework/PropTypes'
CachedState         = require 'ui/framework/mixins/CachedState'
Navigator           = require 'ui/framework/mixins/Navigator'
FollowingPanelState = require 'ui/screens/workspace/panels/following/FollowingPanelState'
DrawerItem          = React.createFactory(require 'ui/common/DrawerItem')
Icon                = React.createFactory(require 'ui/common/Icon')
{span}              = React.DOM
#--------------------------------------------------------------------------------

FollowingDrawerItem = React.createClass {

  displayName: 'FollowingDrawerItem'

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    cards: cache('myFollowedCards').get()
  }

  isReady: ->
    @state.cards?

  render: ->

    classes = classSet [
      'drawer-item'
      'active' if @getScreen('workspace').isPanelVisible('following')
    ]

    DrawerItem {
      className: classes
      icon: 'follow'
      label: 'Following'
      badge: @state.cards.length if @state.cards?.length > 0
      onClick: @toggleFollowing
    }

  toggleFollowing: ->
    @getScreen('workspace').togglePanel(new FollowingPanelState())

}

module.exports = FollowingDrawerItem
