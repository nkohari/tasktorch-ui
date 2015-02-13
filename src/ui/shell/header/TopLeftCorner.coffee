_                   = require 'lodash'
React               = require 'react'
Router              = require 'react-router'
PropTypes           = require 'framework/PropTypes'
Url                 = require 'framework/Url'
Frame               = React.createFactory(require 'ui/common/Frame')
ComposeButton       = React.createFactory(require 'ui/shell/header/ComposeButton')
SidebarToggleButton = React.createFactory(require 'ui/shell/header/SidebarToggleButton')
SearchButton        = React.createFactory(require 'ui/shell/header/SearchButton')

TopLeftCorner = React.createClass {

  displayName: 'TopLeftCorner'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'top-left'},
      SidebarToggleButton {}
      ComposeButton {currentOrg: @props.currentOrg}
      SearchButton {currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = TopLeftCorner
