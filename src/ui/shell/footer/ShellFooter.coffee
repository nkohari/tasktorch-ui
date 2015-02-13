_                 = require 'lodash'
React             = require 'react'
Router            = require 'react-router'
PropTypes         = require 'framework/PropTypes'
Url               = require 'framework/Url'
Frame             = React.createFactory(require 'ui/common/Frame')
BottomLeftCorner  = React.createFactory(require 'ui/shell/footer/BottomLeftCorner')
BottomRightCorner = React.createFactory(require 'ui/shell/footer/BottomRightCorner')

ShellFooter = React.createClass {

  displayName: 'ShellFooter'

  mixins: [Router.State]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'shell-footer'},
      BottomLeftCorner  {currentOrg: @props.currentOrg, currentUser: @props.currentUser}
      BottomRightCorner {currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = ShellFooter
