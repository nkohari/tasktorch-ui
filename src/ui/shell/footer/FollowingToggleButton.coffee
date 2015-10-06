#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
UserToggledPanelEvent = require 'events/ui/UserToggledPanelEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
ViewContext           = require 'ui/framework/mixins/ViewContext'
FollowingPanelSpec    = require 'ui/framework/panels/FollowingPanelSpec'
Icon                  = React.createFactory(require 'ui/common/Icon')
Link                  = React.createFactory(require 'ui/common/Link')
{span}                = React.DOM
#--------------------------------------------------------------------------------

FollowingToggleButton = React.createClass {

  displayName: 'FollowingToggleButton'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'button'
      'active' if @isPanelOpen('following')
    ]

    Link {className: classes, hotkey: 'f', onClick: @toggleFollowing},
      Icon {name: 'follow'}
      span {className: 'count'}, @props.cards?.length or 0

  toggleFollowing: ->
    @publish new UserToggledPanelEvent(new FollowingPanelSpec())

}

module.exports = FollowingToggleButton
