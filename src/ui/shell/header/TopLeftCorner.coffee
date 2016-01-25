#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Button             = React.createFactory(require 'ui/common/Button')
ComposeMenu        = React.createFactory(require 'ui/shell/header/ComposeMenu')
DrawerToggleButton = React.createFactory(require 'ui/shell/header/DrawerToggleButton')
OverlayTrigger     = React.createFactory(require 'ui/common/OverlayTrigger')
{div}              = React.DOM
#--------------------------------------------------------------------------------
require './TopLeftCorner.styl'
#--------------------------------------------------------------------------------

TopLeftCorner = React.createClass {

  displayName: 'TopLeftCorner'

  render: ->

    div {className: 'top-left'},
      DrawerToggleButton {}
      OverlayTrigger {className: 'compose menu-button', overlay: ComposeMenu {}},
        Button {text: 'Create', caret: true}

}

module.exports = TopLeftCorner
