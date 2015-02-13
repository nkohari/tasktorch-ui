_              = require 'lodash'
React          = require 'react'
Router         = require 'react-router'
PropTypes      = require 'framework/PropTypes'
Url            = require 'framework/Url'
Frame          = React.createFactory(require 'ui/common/Frame')
Navigation     = React.createFactory(require 'ui/shell/header/Navigation')
TopLeftCorner  = React.createFactory(require 'ui/shell/header/TopLeftCorner')
TopRightCorner = React.createFactory(require 'ui/shell/header/TopRightCorner')

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-header'},
      TopLeftCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}
      Navigation {}
      TopRightCorner {currentUser: @props.currentUser}

}

module.exports = ShellHeader
