_           = require 'lodash'
React       = require 'react'
mergeProps  = require 'common/util/mergeProps'
classSet    = require 'common/util/classSet'
PropTypes   = require 'ui/framework/PropTypes'
Actor       = require 'ui/framework/mixins/Actor'
CachedState = require 'ui/framework/mixins/CachedState'
Frame       = React.createFactory(require 'ui/common/Frame')
KindIcon    = React.createFactory(require 'ui/common/KindIcon')
PanelHeader = React.createFactory(require 'ui/common/PanelHeader')
CardHeader  = React.createFactory(require 'ui/screens/workspace/panels/card/CardHeader')
CardBody    = React.createFactory(require 'ui/screens/workspace/panels/card/CardBody')
CardFooter  = React.createFactory(require 'ui/screens/workspace/panels/card/CardFooter')
{a}         = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  propTypes:
    id:          PropTypes.id
    currentUser: PropTypes.User

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    card  = cache('cards').get(@props.id)
    kind  = cache('kinds').get(card.kind)   if card?
    stack = cache('stacks').get(card.stack) if card?.stack?
    {card, kind, stack}

  isReady: ->
    @state.card? and @state.kind?

  render: ->

    props = mergeProps _.omit(@props, 'id'), {
      className: classSet [
        'card'
        'panel'
        @state.card.status.toLowerCase() if @state.card?
      ]
      @isReady
    }

    Frame props,
      PanelHeader {panelid: @props.id, icon: KindIcon {kind: @state.kind}},
        "#{@state.kind?.name} #{@state.card?.number}"
      CardHeader {card: @state.card, kind: @state.kind, stack: @state.stack, currentUser: @props.currentUser}
      CardBody   {card: @state.card, kind: @state.kind, stack: @state.stack, currentUser: @props.currentUser}
      CardFooter {card: @state.card, kind: @state.kind, stack: @state.stack, currentUser: @props.currentUser}

}

module.exports = CardPanel
