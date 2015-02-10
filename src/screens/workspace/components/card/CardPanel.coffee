_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'common/PropTypes'
mergeProps         = require 'common/util/mergeProps'
Observe            = require 'mixins/Observe'
CardContext        = require './CardContext'
WorkspaceUrl       = require 'framework/urls/WorkspaceUrl'
CardDisplayedEvent = require 'events/display/CardDisplayedEvent'
KindDisplayedEvent = require 'events/display/KindDisplayedEvent'
Frame              = React.createFactory(require 'common/Frame')
Icon               = React.createFactory(require 'common/Icon')
CardHeader         = React.createFactory(require './CardHeader')
CardBody           = React.createFactory(require './CardBody')
CardFooter         = React.createFactory(require './CardFooter')
Link               = React.createFactory(Router.Link)
{div}              = React.DOM

CardPanel = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardPanel'

  propTypes:
    cardid: PropTypes.id

  mixins: [
    CardContext
    Observe('cards', 'kinds')
    Router.State
  ]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardDisplayedEvent(@props.cardid)

  componentWillReceiveProps: (newProps) ->
    @publish new CardDisplayedEvent(newProps.cardid) if @props.cardid != newProps.cardid

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    card = stores.cards.get(@props.cardid)
    kind = stores.kinds.get(card.kind) if card?
    {card, kind}

  isReady: ->
    @state.card? and @state.kind?

  # Rendering ---------------------------------------------------------------------

  render: ->

    classes = ['card', 'panel']
    classes.push(@state.card.status.toLowerCase()) if @state.card?

    props = mergeProps @props, {
      className: classes.join(' ')
      isReady:   @isReady
    }

    Frame props, [
      @makeCloseLink()
      CardHeader {key: 'header', card: @state.card, kind: @state.kind}
      CardBody   {key: 'body',   card: @state.card, kind: @state.kind}
      CardFooter {key: 'footer', card: @state.card}
    ]

  # Utility -----------------------------------------------------------------------

  makeCloseLink: ->
    url = new WorkspaceUrl(this)
    url.removeCard(@props.cardid)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardPanel
