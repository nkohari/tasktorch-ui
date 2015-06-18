#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react/addons'
PropTypes           = require 'ui/framework/PropTypes'
ShellContext        = require 'ui/framework/mixins/ShellContext'
Screen               = React.createFactory(require 'ui/common/Screen')
BigPicturePanelList = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanelList')
BigPictureDrawer    = React.createFactory(require 'ui/screens/bigPicture/drawer/BigPictureDrawer')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------
require './BigPictureScreen.styl'
#--------------------------------------------------------------------------------

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  propTypes:
    drawer: PropTypes.bool

  mixins: [ShellContext]

  componentDidMount: ->
    document.title = "TaskTorch | Big Picture | #{@getCurrentOrg().name}"

  render: ->

    Screen {className: 'big-picture'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        BigPictureDrawer {} if @props.drawer
      BigPicturePanelList {panels: @props.panels}

}

module.exports = BigPictureScreen
