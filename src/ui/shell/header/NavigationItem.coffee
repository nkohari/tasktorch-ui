_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Icon      = React.createFactory(require 'ui/common/Icon')

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [Router.State]

  propTypes:
    screen:       PropTypes.string
    title:        PropTypes.string
    activeScreen: PropTypes.string

  render: ->

    url = new Url(this)
    url.screen = @props.screen

    classes = []
    classes.push('active') if @props.screen == @props.activeScreen

    ListItem {className: classes.join(' ')},
      Link url.makeLinkProps(),
        Icon {name: @props.screen}
        @props.title

}

module.exports = NavigationItem
