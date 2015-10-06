#--------------------------------------------------------------------------------
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
IdentityContext = require 'ui/framework/mixins/IdentityContext'
Button          = React.createFactory(require 'ui/common/Button')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
OrgContextMenu  = React.createFactory(require 'ui/overlays/OrgContextMenu')
{div}           = React.DOM
#--------------------------------------------------------------------------------
require './TopRightCorner.styl'
#--------------------------------------------------------------------------------

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  mixins: [IdentityContext]

  render: ->

    overlay = OrgContextMenu {}

    div {className: 'top-right'},
      OverlayTrigger {className: 'org menu-button', overlay},
        Button {text: @getCurrentOrg().name, caret: true}

}

module.exports = TopRightCorner
