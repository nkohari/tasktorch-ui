_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
Frame               = React.createFactory(require 'ui/common/Frame')
BigPicturePanelList = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanelList')
BigPictureSidebar   = React.createFactory(require 'ui/screens/bigPicture/sidebar/BigPictureSidebar')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    sidebar:     PropTypes.bool

  render: ->

    Frame {className: 'big-picture screen'},
      CSSTransitionGroup {component: 'div', className: 'sidebar-container', transitionName: 'slide'},
        BigPictureSidebar {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.sidebar
      BigPicturePanelList {currentOrg: @props.currentOrg, currentUser: @props.currentUser, panels: @props.panels}

}

module.exports = BigPictureScreen
