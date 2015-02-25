_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PropTypes = require 'ui/framework/PropTypes'
UrlAware  = require 'ui/framework/mixins/UrlAware'
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Icon      = React.createFactory(require 'ui/common/Icon')

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [UrlAware]

  propTypes:
    screen: PropTypes.string
    title:  PropTypes.string

  render: ->

    classes = classSet [
      'active' if @getCurrentUrl().getScreen() == @props.screen
    ]

    ListItem {},
      Link {className: classes, @getLinkUrl},
        Icon {name: @props.screen}
        @props.title

  getLinkUrl: (currentUrl) ->
    currentUrl.setScreen(@props.screen)

}

module.exports = NavigationItem
