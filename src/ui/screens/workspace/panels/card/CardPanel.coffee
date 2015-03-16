_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
mergeProps    = require 'common/util/mergeProps'
classSet      = require 'common/util/classSet'
Frame         = React.createFactory(require 'ui/common/Frame')
Icon          = React.createFactory(require 'ui/common/Icon')
CardCloseLink = React.createFactory(require 'ui/screens/workspace/panels/card/CardCloseLink')
CardHeader    = React.createFactory(require 'ui/screens/workspace/panels/card/CardHeader')
CardBody      = React.createFactory(require 'ui/screens/workspace/panels/card/CardBody')
CardFooter    = React.createFactory(require 'ui/screens/workspace/panels/card/CardFooter')

CardPanel = React.createClass {

  displayName: 'CardPanel'

  propTypes:
    cardid:      PropTypes.id
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    card = cache('cards').get(@props.cardid)
    kind = cache('kinds').get(card.kind) if card?
    {card, kind}

  isReady: ->
    @state.card? and @state.kind?

  render: ->

    props = mergeProps @props, {
      className: classSet [
        'card'
        'panel'
        @state.card.status.toLowerCase() if @state.card?
      ]
      @isReady
    }

    Frame props,
      CardCloseLink {card: @state.card}
      CardHeader    {card: @state.card, kind: @state.kind, currentUser: @props.currentUser}
      CardBody      {card: @state.card, kind: @state.kind, currentUser: @props.currentUser}
      CardFooter    {card: @state.card, currentUser: @props.currentUser}

}

module.exports = CardPanel
