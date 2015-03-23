_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
Navigator = require 'ui/framework/mixins/Navigator'
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Icon      = React.createFactory(require 'ui/common/Icon')

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [Navigator]

  propTypes:
    hotkey: PropTypes.string
    screen: PropTypes.string
    title:  PropTypes.string

  render: ->

    classes = classSet [
      'active' if @getCurrentScreen() is @getScreen(@props.screen)
    ]

    ListItem {},
      Link {className: classes, hotkey: @props.hotkey, onClick: @showScreen},
        Icon {name: @props.screen}
        @props.title

  showScreen: ->
    @getScreen(@props.screen).navigate()

}

module.exports = NavigationItem
