_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'common/PropTypes'
mergeProps         = require 'common/util/mergeProps'
Constants          = require 'framework/Constants'
Observe            = require 'mixins/Observe'
ActiveUrl          = require 'mixins/ActiveUrl'
CardContext        = require './CardContext'
WorkspaceUrl       = require '../../WorkspaceUrl'
CardDisplayedEvent = require 'events/display/CardDisplayedEvent'
KindDisplayedEvent = require 'events/display/KindDisplayedEvent'
Icon               = React.createFactory(require 'common/Icon')
CardHeader         = React.createFactory(require './CardHeader')
CardDetails        = React.createFactory(require './CardDetails')
CardFooter         = React.createFactory(require './CardFooter')
Link               = React.createFactory(Router.Link)
{div}              = React.DOM

CardPanel = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardPanel'

  propTypes:
    cardId: PropTypes.id

  mixins: [
    CardContext
    Observe('cards', 'kinds')
    ActiveUrl(WorkspaceUrl)
  ]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardDisplayedEvent(@props.cardId)

  componentWillReceiveProps: (newProps) ->
    @publish new CardDisplayedEvent(newProps.cardId) if @props.cardId != newProps.cardId

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    card = stores.cards.get(@props.cardId)
    kind = stores.kinds.get(card.kind) if card?
    {card, kind}

  ready: ->
    return {
      card: @state.card?
      kind: @state.kind?
    }

  # Rendering ---------------------------------------------------------------------

  render: ->

    classes = ['card', 'panel']
    classes.push(@state.card.status.toLowerCase()) if @state.card?

    props = mergeProps @props, {
      className: classes.join(' ')
    }

    div props, @contents()

  children: ->
    return [
      @makeCloseLink()
      CardHeader  {key: 'header',  card: @state.card, kind: @state.kind}
      CardDetails {key: 'details', card: @state.card, kind: @state.kind}
      CardFooter  {key: 'footer',  card: @state.card}
    ]

  # Utility -----------------------------------------------------------------------

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardPanel
