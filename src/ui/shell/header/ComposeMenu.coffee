#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
EventOrigin          = require 'data/enums/EventOrigin'
UserCreatedCardEvent = require 'events/ui/UserCreatedCardEvent'
Actor                = require 'ui/framework/mixins/Actor'
Navigator            = require 'ui/framework/mixins/Navigator'
PropTypes            = require 'ui/framework/PropTypes'
CardPanelState       = require 'ui/screens/workspace/panels/card/CardPanelState'
Button               = React.createFactory(require 'ui/common/Button')
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
Icon                 = React.createFactory(require 'ui/common/Icon')
List                 = React.createFactory(require 'ui/common/List')
ListItem             = React.createFactory(require 'ui/common/ListItem')
Overlay              = React.createFactory(require 'ui/common/Overlay')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
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
      a {key: kind.id, onClick: @onItemClicked.bind(this, kind)},
        Icon {name: 'card', color: kind.color}
        kind.name

    ContextMenu {hideOverlay: @props.hideOverlay}, items

  onItemClicked: (kind, event) ->
    @publish new UserCreatedCardEvent(@props.org.id, kind.id)

  onCardCreated: (event) ->
    return unless event.origin is EventOrigin.Local
    @getScreen('workspace').addPanel(new CardPanelState(event.card.id))

}

module.exports = ComposeMenu
