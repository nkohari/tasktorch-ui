#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
EventOrigin          = require 'data/enums/EventOrigin'
UserCreatedCardEvent = require 'events/ui/UserCreatedCardEvent'
Actor                = require 'ui/framework/mixins/Actor'
Navigator            = require 'ui/framework/mixins/Navigator'
PropTypes            = require 'ui/framework/PropTypes'
CardPanelState       = require 'ui/screens/workspace/panels/card/CardPanelState'
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

  mixins: [Actor, Navigator]

  listensFor: ['CardCreated']

  render: ->

    items = _.map @props.kinds, (kind) =>
      MenuOption {key: kind.id, onActivated: @createCard.bind(this, kind)},
        Icon {name: 'card', color: kind.color}
        kind.name

    ContextMenu {hideOverlay: @props.hideOverlay}, items

  createCard: (kind) ->
    @publish new UserCreatedCardEvent(@props.org.id, kind.id)

  # TODO: This should be moved to ViewStore when it's created
  onCardCreated: (event) ->
    return unless event.origin is EventOrigin.Local
    @getScreen('workspace').addPanel(new CardPanelState(event.card.id))

}

module.exports = ComposeMenu
