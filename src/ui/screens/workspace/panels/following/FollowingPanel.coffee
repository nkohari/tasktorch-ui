_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'ui/framework/PropTypes'
mergeProps         = require 'common/util/mergeProps'
CachedState        = require 'ui/framework/mixins/CachedState'
PropTypes          = require 'ui/framework/PropTypes'
Frame              = React.createFactory(require 'ui/common/Frame')
FollowingCloseLink = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingCloseLink')
FollowingHeader    = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingHeader')
FollowingCardList  = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingCardList')
FollowingFooter    = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingFooter')

FollowingPanel = React.createClass {

  displayName: 'FollowingPanel'

  propTypes:
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    {cards: cache('myFollowedCards').get()}

  isReady: ->
    @state.cards?

  render: ->

    props = mergeProps @props, {
      className: 'following panel'
      @isReady
    }
    
    Frame props,
      FollowingCloseLink {}
      FollowingHeader {}
      FollowingCardList {cards: @state.cards}
      FollowingFooter {}

}

module.exports = FollowingPanel
