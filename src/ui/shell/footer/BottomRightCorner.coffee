#--------------------------------------------------------------------------------
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
IdentityContext = require 'ui/framework/mixins/IdentityContext'
Avatar          = React.createFactory(require 'ui/common/Avatar')
Frame           = React.createFactory(require 'ui/common/Frame')
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
UserContextMenu = React.createFactory(require 'ui/overlays/UserContextMenu')
{div}           = React.DOM
#--------------------------------------------------------------------------------
require './BottomRightCorner.styl'
#--------------------------------------------------------------------------------

BottomRightCorner = React.createClass {

  displayName: 'BottomRightCorner'

  mixins: [IdentityContext]

  render: ->

    user = @getCurrentUser()
    overlay = UserContextMenu {user}

    div {className: 'bottom-right'},
      OverlayTrigger {overlay},
        div {className: 'current-user'},
          Icon {name: 'trigger-up'}
          Avatar {user, size: 32, presence: true}

}

module.exports = BottomRightCorner
