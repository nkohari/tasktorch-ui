_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
ShellContext       = require 'ui/framework/mixins/ShellContext'
Button             = React.createFactory(require 'ui/common/Button')
ComposeMenu        = React.createFactory(require 'ui/shell/header/ComposeMenu')
DrawerToggleButton = React.createFactory(require 'ui/shell/header/DrawerToggleButton')
OverlayTrigger     = React.createFactory(require 'ui/common/OverlayTrigger')
{div}              = React.DOM

TopLeftCorner = React.createClass {

  displayName: 'TopLeftCorner'

  mixins: [CachedState, ShellContext]

  getCachedState: (cache) ->
    {kinds: cache('kindsByOrg').get(@getCurrentOrg().id)}

  render: ->

    overlay = ComposeMenu {org: @getCurrentOrg(), kinds: @state.kinds}

    div {className: 'top-left'},
      DrawerToggleButton {}
      OverlayTrigger {className: 'compose menu-button', overlay},
        Button {text: 'Compose', caret: true}

}

module.exports = TopLeftCorner
