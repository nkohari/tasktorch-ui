_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
Frame               = React.createFactory(require 'ui/common/Frame')
ComposeMenu         = React.createFactory(require 'ui/shell/header/ComposeMenu')
SidebarToggleButton = React.createFactory(require 'ui/shell/header/SidebarToggleButton')

TopLeftCorner = React.createClass {

  displayName: 'TopLeftCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-left'},
      SidebarToggleButton {}
      ComposeMenu {currentOrg: @props.currentOrg}

}

module.exports = TopLeftCorner
