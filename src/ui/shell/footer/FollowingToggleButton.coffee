_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
UrlAware  = require 'ui/framework/mixins/UrlAware'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
{span}    = React.DOM

FollowingToggleButton = React.createClass {

  displayName: 'FollowingToggleButton'

  propTypes:
    cards: PropTypes.arrayOf(PropTypes.Card)

  mixins: [UrlAware]

  render: ->

    classes = classSet [
      'button'
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forFollowing())
    ]

    Link {className: classes, hotkey: 'f', @getLinkUrl},
      Icon {name: 'follow'}
      span {className: 'count'}, @props.cards?.length or 0

  getLinkUrl: (currentUrl) ->
    currentUrl.setScreen('workspace').togglePanel(PanelKey.forFollowing())

}

module.exports = FollowingToggleButton
