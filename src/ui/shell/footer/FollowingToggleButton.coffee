_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
Navigator = require 'ui/framework/mixins/Navigator'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
{span}    = React.DOM

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
    @getScreen('workspace').togglePanel {
      type: 'following'
      id:   'following'
    }

}

module.exports = FollowingToggleButton
