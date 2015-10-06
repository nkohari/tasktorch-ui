#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
classSet                = require 'common/util/classSet'
UserSelectedScreenEvent = require 'events/ui/UserSelectedScreenEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ViewContext             = require 'ui/framework/mixins/ViewContext'
Link                    = React.createFactory(require 'ui/common/Link')
Icon                    = React.createFactory(require 'ui/common/Icon')
{li}                    = React.DOM
#--------------------------------------------------------------------------------
require './NavigationItem.styl'
#--------------------------------------------------------------------------------

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [Actor, ViewContext]

  propTypes:
    hotkey: PropTypes.string
    screen: PropTypes.string
    title:  PropTypes.string

  render: ->

    classes = classSet [
      'navigation-item'
      @props.screen
      'active' if @getCurrentScreen() == @props.screen
    ]

    li {className: classes},
      Link {hotkey: @props.hotkey, onClick: @showScreen},
        Icon {name: @props.screen}
        @props.title

  showScreen: ->
    @publish new UserSelectedScreenEvent(@props.screen)

}

module.exports = NavigationItem
