_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'framework/PropTypes'
mergeProps         = require 'framework/util/mergeProps'
Observe            = require 'framework/mixins/Observe'
CardContext        = require './CardContext'
Url                = require 'framework/Url'
CardDisplayedEvent = require 'events/display/CardDisplayedEvent'
KindDisplayedEvent = require 'events/display/KindDisplayedEvent'
Frame              = React.createFactory(require 'ui/common/Frame')
Icon               = React.createFactory(require 'ui/common/Icon')
CardCloseLink      = React.createFactory(require 'ui/panels/card/CardCloseLink')
CardHeader         = React.createFactory(require 'ui/panels/card/CardHeader')
CardBody           = React.createFactory(require 'ui/panels/card/CardBody')
CardFooter         = React.createFactory(require 'ui/panels/card/CardFooter')
{div}              = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  propTypes:
    cardid: PropTypes.id

  mixins: [
    CardContext
    Observe('cards', 'kinds')
    Router.State
  ]

  componentDidMount: ->
    @publish new CardDisplayedEvent(@props.cardid)

  componentWillReceiveProps: (newProps) ->
    @publish new CardDisplayedEvent(newProps.cardid) if @props.cardid != newProps.cardid

  sync: (stores) ->
    card = stores.cards.get(@props.cardid)
    kind = stores.kinds.get(card.kind) if card?
    {card, kind}

  isReady: ->
    @state.card? and @state.kind?

  render: ->

    classes = ['card', 'panel']
    classes.push(@state.card.status.toLowerCase()) if @state.card?

    props = mergeProps @props, {
      className: classes.join(' ')
      isReady:   @isReady
    }

    Frame props,
      CardCloseLink {card: @state.card}
      CardHeader    {card: @state.card, kind: @state.kind}
      CardBody      {card: @state.card, kind: @state.kind}
      CardFooter    {card: @state.card}

}

module.exports = CardPanel
