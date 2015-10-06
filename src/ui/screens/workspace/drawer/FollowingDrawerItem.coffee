#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
UserToggledPanelEvent = require 'events/ui/UserToggledPanelEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
ViewContext           = require 'ui/framework/mixins/ViewContext'
FollowingPanelSpec    = require 'ui/framework/panels/FollowingPanelSpec'
DrawerItem            = React.createFactory(require 'ui/common/DrawerItem')
Icon                  = React.createFactory(require 'ui/common/Icon')
{span}                = React.DOM
#--------------------------------------------------------------------------------

FollowingDrawerItem = React.createClass {

  displayName: 'FollowingDrawerItem'

  mixins: [Actor, CachedState, ViewContext]

  getCachedState: (cache) -> {
    cards: cache('myFollowedCards').get()
  }

  isReady: ->
    @state.cards?

  render: ->

    classes = classSet [
      'drawer-item'
      'active' if @isPanelOpen('following')
    ]

    DrawerItem {
      className: classes
      icon: 'follow'
      label: 'Following'
      badge: @state.cards.length if @state.cards?.length > 0
      onClick: @toggleFollowing
    }

  toggleFollowing: ->
    @publish new UserToggledPanelEvent(new FollowingPanelSpec())

}

module.exports = FollowingDrawerItem
