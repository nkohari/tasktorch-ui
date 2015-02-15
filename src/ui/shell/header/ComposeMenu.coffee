_                 = require 'lodash'
React             = require 'react'
Router            = require 'react-router'
Observe           = require 'framework/mixins/Observe'
PropTypes         = require 'framework/PropTypes'
CreateCardRequest = require 'requests/CreateCardRequest'
Url               = require 'framework/Url'
MenuButton        = React.createFactory(require 'ui/common/MenuButton')
MenuItem          = React.createFactory(require 'ui/common/MenuItem')
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
      MenuItem {key: kind.id, value: kind},
        span {className: 'color-marker', style: {backgroundColor: kind.color}}
        kind.name

    MenuButton {@isReady, text: 'Compose', className: 'compose', @onItemClicked}, items

  onItemClicked: (event) ->
    kind    = event.value
    url     = new Url(this)
    request = new CreateCardRequest(url.orgid, kind.id)
    @execute request, (err, card) =>
      url.addCard(card.id)
      props = url.makeLinkProps()
      @transitionTo(props.to, props.params, props.query)

}

module.exports = ComposeMenu
