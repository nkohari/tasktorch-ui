#--------------------------------------------------------------------------------
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
ShellContext   = require 'ui/framework/mixins/ShellContext'
Button         = React.createFactory(require 'ui/common/Button')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')
OrgContextMenu = React.createFactory(require 'ui/overlays/OrgContextMenu')
{div}          = React.DOM
#--------------------------------------------------------------------------------
require './TopRightCorner.styl'
#--------------------------------------------------------------------------------

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  mixins: [ShellContext]

  render: ->

    overlay = OrgContextMenu {}

    div {className: 'top-right'},
      OverlayTrigger {className: 'org menu-button', overlay},
        Button {text: @getCurrentOrg().name, caret: true}

}

module.exports = TopRightCorner
