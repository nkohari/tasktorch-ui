_                    = require 'lodash'
React                = require 'react'
EventOrigin          = require 'data/enums/EventOrigin'
UserCreatedCardEvent = require 'events/ui/UserCreatedCardEvent'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
Navigator            = require 'ui/framework/mixins/Navigator'
ShellContext         = require 'ui/framework/mixins/ShellContext'
PropTypes            = require 'ui/framework/PropTypes'
CardPanelState       = require 'ui/screens/workspace/panels/card/CardPanelState'
Button               = React.createFactory(require 'ui/common/Button')
KindIcon             = React.createFactory(require 'ui/common/KindIcon')
List                 = React.createFactory(require 'ui/common/List')
ListItem             = React.createFactory(require 'ui/common/ListItem')
Overlay              = React.createFactory(require 'ui/common/Overlay')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
{a, li, ul}          = React.DOM

ComposeMenu = React.createClass {

  displayName: 'ComposeMenu'

  mixins: [Actor, CachedState, Navigator, ShellContext]

  listensFor: ['CardCreated']

  getCachedState: (cache) ->
    {kinds: cache('kindsByOrg').get(@getCurrentOrg().id)}

  isReady: ->
    @state.kinds

  render: ->

    items = _.map @state.kinds, (kind) =>
      li {key: kind.id, className: 'menu-item'},
        a {onClick: @onItemClicked.bind(this, kind)},
          KindIcon {kind}
          kind.name

    overlay = ul {className: 'overlay menu'}, items

    OverlayTrigger {@isReady, ref: 'trigger', className: 'compose menu-button', overlay},
      Button {text: 'Compose', caret: true}

  onItemClicked: (kind, event) ->
    @publish new UserCreatedCardEvent(@getCurrentOrg().id, kind.id)
    @refs.trigger.hideOverlay()

  onCardCreated: (event) ->
    return unless event.origin is EventOrigin.Local
    @getScreen('workspace').addPanel(new CardPanelState(event.card.id))

}

module.exports = ComposeMenu
