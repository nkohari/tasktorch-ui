_                   = require 'lodash'
React               = require 'react'
classSet            = require 'common/util/classSet'
PropTypes           = require 'ui/framework/PropTypes'
CachedState         = require 'ui/framework/mixins/CachedState'
Navigator           = require 'ui/framework/mixins/Navigator'
FollowingPanelState = require 'ui/screens/workspace/panels/following/FollowingPanelState'
Frame               = React.createFactory(require 'ui/common/Frame')
Icon                = React.createFactory(require 'ui/common/Icon')
Link                = React.createFactory(require 'ui/common/Link')
{span}              = React.DOM

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

    Link {className: classes, onClick: @toggleFollowing},
      Icon {name: 'follow'}
      span {className: 'name'}, 'Following'
      span {className: 'count'}, @state.cards.length if @state.cards?.length > 0

  toggleFollowing: ->
    @getScreen('workspace').togglePanel(new FollowingPanelState())

}

module.exports = FollowingDrawerItem
