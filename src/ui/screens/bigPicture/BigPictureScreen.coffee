_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
Frame               = React.createFactory(require 'ui/common/Frame')
BigPicturePanelList = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanelList')
BigPictureDrawer    = React.createFactory(require 'ui/screens/bigPicture/drawer/BigPictureDrawer')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    drawer:     PropTypes.bool

  render: ->

    Frame {className: 'big-picture screen'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        BigPictureDrawer {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.drawer
      BigPicturePanelList {currentOrg: @props.currentOrg, currentUser: @props.currentUser, panels: @props.panels}

}

module.exports = BigPictureScreen
