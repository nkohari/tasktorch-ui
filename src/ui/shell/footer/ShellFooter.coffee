_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
Frame             = React.createFactory(require 'ui/common/Frame')
BottomLeftCorner  = React.createFactory(require 'ui/shell/footer/BottomLeftCorner')
BottomRightCorner = React.createFactory(require 'ui/shell/footer/BottomRightCorner')

ShellFooter = React.createClass {

  displayName: 'ShellFooter'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-footer'},
      BottomLeftCorner  {currentOrg: @props.currentOrg, currentUser: @props.currentUser}
      BottomRightCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = ShellFooter
