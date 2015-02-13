_                             = require 'lodash'
React                         = require 'react'
Router                        = require 'react-router'
PropTypes                     = require 'framework/PropTypes'
Url                           = require 'framework/Url'
Observe                       = require 'framework/mixins/Observe'
MyFollowedCardsDisplayedEvent = require 'events/display/MyFollowedCardsDisplayedEvent'
Frame                         = React.createFactory(require 'ui/common/Frame')
Icon                          = React.createFactory(require 'ui/common/Icon')
Link                          = React.createFactory(require 'ui/common/Link')
List                          = React.createFactory(require 'ui/common/List')
ListItem                      = React.createFactory(require 'ui/common/ListItem')
Text                          = React.createFactory(require 'ui/common/Text')

FollowingSidebarItem = React.createClass {

  displayName: 'FollowingSidebarItem'

  propTypes:
    currentUser: PropTypes.User

  mixins: [
    Observe('cards')
    Router.State
  ]

  componentDidMount: ->
    @publish new MyFollowedCardsDisplayedEvent()

  sync: (stores) ->
    {cards: stores.cards.getMyFollowedCards(@props.currentUser.id)}

  isReady: ->
    @state.cards?

  render: ->

    url = new Url(this)
    url.showFollowing()

    Frame {@isReady, className: 'group'},
      List {},
        ListItem {className: 'sidebar-item'},
          Link url.makeLinkProps(),
            Icon {name: 'follow'}
            Text {className: 'name'}, 'Following'
            Text {className: 'count'}, @state.cards.length if @state.cards.length > 0

}

module.exports = FollowingSidebarItem
