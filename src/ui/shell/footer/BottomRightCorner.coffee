#--------------------------------------------------------------------------------
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
ShellContext    = require 'ui/framework/mixins/ShellContext'
Avatar          = React.createFactory(require 'ui/common/Avatar')
Frame           = React.createFactory(require 'ui/common/Frame')
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
UserContextMenu = React.createFactory(require 'ui/shell/footer/UserContextMenu')
{div}           = React.DOM
#--------------------------------------------------------------------------------
require './BottomRightCorner.styl'
#--------------------------------------------------------------------------------

BottomRightCorner = React.createClass {

  displayName: 'BottomRightCorner'

  mixins: [ShellContext]

  render: ->

    user = @getCurrentUser()
    overlay = UserContextMenu {user}

    div {className: 'bottom-right'},
      OverlayTrigger {overlay},
        div {className: 'current-user'},
          Icon {name: 'caret-flipped'}
          Avatar {user}

}

module.exports = BottomRightCorner
