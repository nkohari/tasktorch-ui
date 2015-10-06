#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
ViewContext         = require 'ui/framework/mixins/ViewContext'
IdentityContext     = require 'ui/framework/mixins/IdentityContext'
Screen              = React.createFactory(require 'ui/common/Screen')
BigPicturePanelList = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanelList')
BigPictureDrawer    = React.createFactory(require 'ui/screens/bigPicture/drawer/BigPictureDrawer')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------
require './BigPictureScreen.styl'
#--------------------------------------------------------------------------------

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [ViewContext, IdentityContext]

  componentDidMount: ->
    document.title = "TaskTorch | Big Picture | #{@getCurrentOrg().name}"

  render: ->

    Screen {className: 'big-picture'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        BigPictureDrawer {} if @isDrawerOpen()
      BigPicturePanelList {panels: @getOpenPanels()}

}

module.exports = BigPictureScreen
