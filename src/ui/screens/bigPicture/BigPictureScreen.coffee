_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Frame              = React.createFactory(require 'ui/common/Frame')
BigPictureSidebar  = React.createFactory(require 'ui/screens/bigPicture/sidebar/BigPictureSidebar')
TeamPanel          = React.createFactory(require 'ui/screens/bigPicture/TeamPanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    sidebar:     PropTypes.bool

  render: ->

    Frame {className: 'bigPicture screen'},
      CSSTransitionGroup {component: 'div', className: 'sidebar-container', transitionName: 'slide'},
        BigPictureSidebar {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.sidebar
      div {className: 'content'},
        TeamPanel {teamid: '1'}

}

module.exports = BigPictureScreen
