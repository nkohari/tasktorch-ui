_           = require 'lodash'
React       = require 'react'
classSet    = require 'common/util/classSet'
PanelKey    = require 'ui/framework/PanelKey'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
UrlAware    = require 'ui/framework/mixins/UrlAware'
Frame       = React.createFactory(require 'ui/common/Frame')
Icon        = React.createFactory(require 'ui/common/Icon')
Link        = React.createFactory(require 'ui/common/Link')
List        = React.createFactory(require 'ui/common/List')
ListItem    = React.createFactory(require 'ui/common/ListItem')
Text        = React.createFactory(require 'ui/common/Text')

FollowingSidebarItem = React.createClass {

  displayName: 'FollowingSidebarItem'

  propTypes:
    currentUser: PropTypes.User

  mixins: [CachedState, UrlAware]

  getCachedState: (cache) -> {
    cards: cache('myFollowedCards').get()
  }

  isReady: ->
    @state.cards?

  render: ->

    classes = classSet [
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forFollowing())
    ]

    Frame {@isReady, className: 'group'},
      List {},
        ListItem {className: 'sidebar-item'},
          Link {className: classes, @getLinkUrl},
            Icon {name: 'follow'}
            Text {className: 'name'}, 'Following'
            Text {className: 'count'}, @state.cards.length if @state.cards?.length > 0

  getLinkUrl: (currentUrl) ->
    currentUrl.togglePanel(PanelKey.forFollowing())

}

module.exports = FollowingSidebarItem
