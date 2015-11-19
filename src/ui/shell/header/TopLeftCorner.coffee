#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
IdentityContext    = require 'ui/framework/mixins/IdentityContext'
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

  mixins: [CachedState, IdentityContext]

  getCachedState: (cache) ->
    {kinds: cache('kindsByOrg').get(@getCurrentOrg().id)}

  render: ->

    overlay = ComposeMenu {org: @getCurrentOrg(), kinds: @state.kinds}

    div {className: 'top-left'},
      DrawerToggleButton {}
      OverlayTrigger {className: 'compose menu-button', overlay},
        Button {text: 'Create', caret: true}

}

module.exports = TopLeftCorner
