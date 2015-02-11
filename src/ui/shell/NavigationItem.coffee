_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [Router.State]

  propTypes:
    screen: PropTypes.string
    title:  PropTypes.string

  render: ->

    url = new Url(this)
    url.screen = @props.screen

    ListItem {},
      Link url.makeLinkProps(), @props.title

}

module.exports = NavigationItem
