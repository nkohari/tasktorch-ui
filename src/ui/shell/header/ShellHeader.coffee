_           = require 'lodash'
React       = require 'react'
Router      = require 'react-router'
PropTypes   = require 'framework/PropTypes'
Url         = require 'framework/Url'
Button      = React.createFactory(require 'ui/common/Button')
Frame       = React.createFactory(require 'ui/common/Frame')
Icon        = React.createFactory(require 'ui/common/Icon')
Link        = React.createFactory(require 'ui/common/Link')
Navigation  = React.createFactory(require 'ui/shell/header/Navigation')
LeftCorner  = React.createFactory(require 'ui/shell/header/LeftCorner')
RightCorner = React.createFactory(require 'ui/shell/header/RightCorner')

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-header'},
      LeftCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}
      Navigation {}
      RightCorner {currentUser: @props.currentUser}

}

module.exports = ShellHeader
