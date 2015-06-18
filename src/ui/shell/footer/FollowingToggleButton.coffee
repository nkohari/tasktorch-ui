#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
classSet            = require 'common/util/classSet'
PropTypes           = require 'ui/framework/PropTypes'
Navigator           = require 'ui/framework/mixins/Navigator'
FollowingPanelState = require 'ui/screens/workspace/panels/following/FollowingPanelState'
Icon                = React.createFactory(require 'ui/common/Icon')
Link                = React.createFactory(require 'ui/common/Link')
{span}              = React.DOM
#--------------------------------------------------------------------------------

FollowingToggleButton = React.createClass {

  displayName: 'FollowingToggleButton'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'button'
      'active' if @getScreen('workspace').isPanelVisible('following')
    ]

    Link {className: classes, hotkey: 'f', onClick: @toggleFollowing},
      Icon {name: 'follow'}
      span {className: 'count'}, @props.cards?.length or 0

  toggleFollowing: ->
    @getScreen('workspace').togglePanel(new FollowingPanelState())

}

module.exports = FollowingToggleButton
