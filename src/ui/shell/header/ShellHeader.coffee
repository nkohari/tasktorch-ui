_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Frame          = React.createFactory(require 'ui/common/Frame')
TopCenter      = React.createFactory(require 'ui/shell/header/TopCenter')
TopLeftCorner  = React.createFactory(require 'ui/shell/header/TopLeftCorner')
TopRightCorner = React.createFactory(require 'ui/shell/header/TopRightCorner')

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-header'},
      TopLeftCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}
      TopCenter {}
      TopRightCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = ShellHeader
