_                 = require 'lodash'
React             = require 'react'
Router            = require 'react-router'
Observe           = require 'framework/mixins/Observe'
PropTypes         = require 'framework/PropTypes'
CreateCardRequest = require 'requests/CreateCardRequest'
Url               = require 'framework/Url'
Button            = React.createFactory(require 'ui/common/Button')
List              = React.createFactory(require 'ui/common/List')
ListItem          = React.createFactory(require 'ui/common/ListItem')
Overlay           = React.createFactory(require 'ui/common/Overlay')
OverlayTrigger    = React.createFactory(require 'ui/common/OverlayTrigger')
{span}            = React.DOM

ComposeMenu = React.createClass {

  displayName: 'ComposeMenu'

  mixins: [
    Observe('kinds')
    Router.State
    Router.Navigation
  ]

  propTypes:
    currentOrg: PropTypes.Org

  sync: (stores) ->
    {kinds: stores.kinds.getAll()}

  isReady: ->
    @state.kinds?

  render: ->

    items = _.map @state.kinds, (kind) =>
      ListItem {key: kind.id, onClick: @onItemClicked.bind(this, kind)},
        span {className: 'color-marker', style: {backgroundColor: kind.color}}
        kind.name

    overlay = List {className: 'overlay menu'}, items

    OverlayTrigger {@isReady, ref: 'trigger', className: 'compose menu-button', overlay},
      Button {text: 'Compose', caret: true}

  onItemClicked: (kind, event) ->
    @refs.trigger.hideOverlay()
    url     = new Url(this)
    request = new CreateCardRequest(url.orgid, kind.id)
    @execute request, (err, card) =>
      url.addCard(card.id)
      props = url.makeLinkProps()
      @transitionTo(props.to, props.params, props.query)

}

module.exports = ComposeMenu
