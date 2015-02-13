_                             = require 'lodash'
React                         = require 'react'
Router                        = require 'react-router'
PropTypes                     = require 'framework/PropTypes'
mergeProps                    = require 'framework/util/mergeProps'
Observe                       = require 'framework/mixins/Observe'
MyFollowedCardsDisplayedEvent = require 'events/display/MyFollowedCardsDisplayedEvent'
PropTypes                     = require 'framework/PropTypes'
Url                           = require 'framework/Url'
Frame                         = React.createFactory(require 'ui/common/Frame')
FollowingCloseLink            = React.createFactory(require 'ui/panels/following/FollowingCloseLink')
FollowingHeader               = React.createFactory(require 'ui/panels/following/FollowingHeader')
FollowingCardList             = React.createFactory(require 'ui/panels/following/FollowingCardList')
FollowingFooter               = React.createFactory(require 'ui/panels/following/FollowingFooter')

FollowingPanel = React.createClass {

  displayName: 'FollowingPanel'

  propTypes:
    currentUser: PropTypes.User

  mixins: [Observe('cards')]

  componentDidMount: ->
    @publish new MyFollowedCardsDisplayedEvent()

  sync: (stores) ->
    {cards: stores.cards.getMyFollowedCards(@props.currentUser.id)}

  isReady: ->
    @state.cards?

  render: ->

    props = mergeProps @props, {
      @isReady
      className: 'following panel'
    }
    
    Frame props,
      FollowingCloseLink {}
      FollowingHeader {}
      FollowingCardList {cards: @state.cards}
      FollowingFooter {}

}

module.exports = FollowingPanel
