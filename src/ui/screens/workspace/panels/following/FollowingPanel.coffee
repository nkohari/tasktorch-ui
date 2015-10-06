#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
Router            = require 'react-router'
PropTypes         = require 'ui/framework/PropTypes'
mergeProps        = require 'common/util/mergeProps'
CachedState       = require 'ui/framework/mixins/CachedState'
PropTypes         = require 'ui/framework/PropTypes'
Panel             = React.createFactory(require 'ui/common/Panel')
PanelHeader       = React.createFactory(require 'ui/common/PanelHeader')
FollowingCardList = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingCardList')
FollowingFooter   = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingFooter')
{div}             = React.DOM
#--------------------------------------------------------------------------------
require './FollowingPanel.styl'
#--------------------------------------------------------------------------------

FollowingPanel = React.createClass {

  displayName: 'FollowingPanel'

  mixins: [CachedState]

  getCachedState: (cache) ->
    {cards: cache('myFollowedCards').get()}

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      className: 'following'
    }
    
    Panel props,
      PanelHeader {panelid: 'following', icon: 'follow'},
        'Following'
      div {className: 'content'},
        FollowingCardList {cards: @state.cards}
      FollowingFooter {}

}

module.exports = FollowingPanel
