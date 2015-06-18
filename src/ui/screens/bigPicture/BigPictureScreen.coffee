_                   = require 'lodash'
React               = require 'react/addons'
PropTypes           = require 'ui/framework/PropTypes'
ShellContext        = require 'ui/framework/mixins/ShellContext'
Frame               = React.createFactory(require 'ui/common/Frame')
BigPicturePanelList = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanelList')
BigPictureDrawer    = React.createFactory(require 'ui/screens/bigPicture/drawer/BigPictureDrawer')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  propTypes:
    drawer: PropTypes.bool

  mixins: [ShellContext]

  componentDidMount: ->
    document.title = "TaskTorch | Big Picture | #{@getCurrentOrg().name}"

  render: ->

    Frame {className: 'big-picture screen'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        BigPictureDrawer {} if @props.drawer
      BigPicturePanelList {panels: @props.panels}

}

module.exports = BigPictureScreen
