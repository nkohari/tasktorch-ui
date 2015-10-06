#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
mergeProps           = require 'common/util/mergeProps'
classSet             = require 'common/util/classSet'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
CommandContextMaster = require 'ui/framework/mixins/CommandContextMaster'
Icon                 = React.createFactory(require 'ui/common/Icon')
Panel                = React.createFactory(require 'ui/common/Panel')
PanelHeader          = React.createFactory(require 'ui/common/PanelHeader')
CardHeader           = React.createFactory(require 'ui/screens/workspace/panels/card/CardHeader')
CardBody             = React.createFactory(require 'ui/screens/workspace/panels/card/CardBody')
CardFooter           = React.createFactory(require 'ui/screens/workspace/panels/card/CardFooter')
CardCommand          = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommand')
{div}                = React.DOM
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------
require './CardPanel.styl'
#--------------------------------------------------------------------------------

CardPanel = React.createClass {

  displayName: 'CardPanel'

  propTypes:
    id: PropTypes.id

  mixins: [Actor, CachedState, CommandContextMaster]

  getCachedState: (cache) ->
    card  = cache('cards').get(@props.id)
    kind  = cache('kinds').get(card.kind)   if card?
    stack = cache('stacks').get(card.stack) if card?.stack?
    {card, kind, stack}

  isReady: ->
    @state.card? and @state.kind? and (@state.stack? or not @state.card.stack?)

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      className: classSet [
        'card'
        @state.card.status.toLowerCase() if @state.card?
      ]
      @isReady
    }

    icon = Icon {name: 'card', color: @state.kind?.color}

    Panel props,
      PanelHeader {panelid: @props.id, icon},
        "#{@state.kind?.name} #{@state.card?.number}"
      div {className: 'content'},
        CardHeader {card: @state.card, kind: @state.kind, stack: @state.stack}
        CardBody {card: @state.card, kind: @state.kind, stack: @state.stack}
        CardCommand {command: @getActiveCommand(), card: @state.card, stack: @state.stack}
      CardFooter {card: @state.card, kind: @state.kind, stack: @state.stack}

}

module.exports = CardPanel
