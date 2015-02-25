_                    = require 'lodash'
React                = require 'react'
Router               = require 'react-router'
EventOrigin          = require 'data/enums/EventOrigin'
UserCreatedCardEvent = require 'events/ui/UserCreatedCardEvent'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
UrlAware             = require 'ui/framework/mixins/UrlAware'
PanelKey             = require 'ui/framework/PanelKey'
PropTypes            = require 'ui/framework/PropTypes'
Button               = React.createFactory(require 'ui/common/Button')
List                 = React.createFactory(require 'ui/common/List')
ListItem             = React.createFactory(require 'ui/common/ListItem')
Overlay              = React.createFactory(require 'ui/common/Overlay')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
{span}               = React.DOM

ComposeMenu = React.createClass {

  displayName: 'ComposeMenu'

  propTypes:
    currentOrg: PropTypes.Org

  mixins: [Actor, CachedState, Router.Navigation, UrlAware]

  listensFor: ['CardCreated']

  getCachedState: (cache) ->
    {kinds: cache('kindsByOrg').get(@props.currentOrg.id)}

  isReady: ->
    @state.kinds

  render: ->

    items = _.map @state.kinds, (kind) =>
      ListItem {key: kind.id, onClick: @onItemClicked.bind(this, kind)},
        span {className: 'color-marker', style: {backgroundColor: kind.color}}
        kind.name

    overlay = List {className: 'overlay menu'}, items

    OverlayTrigger {@isReady, ref: 'trigger', className: 'compose menu-button', overlay},
      Button {text: 'Compose', caret: true}

  onItemClicked: (kind, event) ->
    @publish new UserCreatedCardEvent(@props.currentOrg.id, kind.id)
    @refs.trigger.hideOverlay()

  onCardCreated: (event) ->
    return unless event.origin is EventOrigin.Local
    url   = @getCurrentUrl().addPanel(PanelKey.forCard(event.card.id))
    props = url.makeLinkProps()
    @transitionTo('workspace', props.params, props.query)

}

module.exports = ComposeMenu
