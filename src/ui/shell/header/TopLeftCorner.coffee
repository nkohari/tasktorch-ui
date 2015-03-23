_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Frame              = React.createFactory(require 'ui/common/Frame')
ComposeMenu        = React.createFactory(require 'ui/shell/header/ComposeMenu')
DrawerToggleButton = React.createFactory(require 'ui/shell/header/DrawerToggleButton')

TopLeftCorner = React.createClass {

  displayName: 'TopLeftCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-left'},
      DrawerToggleButton {}
      ComposeMenu {currentOrg: @props.currentOrg}

}

module.exports = TopLeftCorner
