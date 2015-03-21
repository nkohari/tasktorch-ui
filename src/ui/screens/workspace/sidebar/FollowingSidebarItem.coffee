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
List                = React.createFactory(require 'ui/common/List')
ListItem            = React.createFactory(require 'ui/common/ListItem')
Text                = React.createFactory(require 'ui/common/Text')

FollowingSidebarItem = React.createClass {

  displayName: 'FollowingSidebarItem'

  propTypes:
    currentUser: PropTypes.User

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    cards: cache('myFollowedCards').get()
  }

  isReady: ->
    @state.cards?

  render: ->

    classes = classSet [
      'active' if @getScreen('workspace').isPanelVisible('following')
    ]

    Frame {@isReady, className: 'group'},
      List {},
        ListItem {className: 'sidebar-item'},
          Link {className: classes, onClick: @toggleFollowing},
            Icon {name: 'follow'}
            Text {className: 'name'}, 'Following'
            Text {className: 'count'}, @state.cards.length if @state.cards?.length > 0

  toggleFollowing: ->
    @getScreen('workspace').togglePanel(new FollowingPanelState())

}

module.exports = FollowingSidebarItem
