#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
EventOrigin          = require 'data/enums/EventOrigin'
KindStatus           = require 'data/enums/KindStatus'
UserCreatedCardEvent = require 'events/ui/UserCreatedCardEvent'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
IdentityContext      = require 'ui/framework/mixins/IdentityContext'
CardPanelSpec        = require 'ui/framework/panels/CardPanelSpec'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
Icon                 = React.createFactory(require 'ui/common/Icon')
MenuOption           = React.createFactory(require 'ui/common/MenuOption')
{a, li, ul}          = React.DOM
#--------------------------------------------------------------------------------

ComposeMenu = React.createClass {

  displayName: 'ComposeMenu'

  propTypes:
    kinds:       PropTypes.arrayOf(PropTypes.Kind)
    org:         PropTypes.Org
    hideOverlay: PropTypes.func

  mixins: [Actor, CachedState, IdentityContext]

  listensFor: ['CardCreated']

  getCachedState: (cache) -> {
    kinds: cache('kindsByOrg').get(@getCurrentOrg().id)
  }

  render: ->

    kinds = _.filter @state.kinds, (k) -> k.status == KindStatus.Normal

    items = _.map kinds, (kind) =>
      MenuOption {key: kind.id, onActivated: @createCard.bind(this, kind)},
        Icon {name: 'card', color: kind.color}
        kind.name

    ContextMenu {hideOverlay: @props.hideOverlay}, items

  createCard: (kind) ->
    @publish new UserCreatedCardEvent(@props.org.id, kind.id)

  onCardCreated: (event) ->
    if event.origin is EventOrigin.Local
      @publish new UserOpenedPanelEvent(new CardPanelSpec(event.card.id))

}

module.exports = ComposeMenu
