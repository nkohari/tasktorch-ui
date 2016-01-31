#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
mergeProps           = require 'common/util/mergeProps'
classSet             = require 'common/util/classSet'
CardCommandType      = require 'data/enums/CardCommandType'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
CommandContextMaster = require 'ui/framework/mixins/CommandContextMaster'
Icon                 = React.createFactory(require 'ui/common/Icon')
Panel                = React.createFactory(require 'ui/common/Panel')
CardHeader           = React.createFactory(require 'ui/screens/workspace/panels/card/CardHeader')
CardOverview         = React.createFactory(require 'ui/screens/workspace/panels/card/CardOverview')
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

  getInitialState: ->
    {hovering: false}

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
      @onDragEnter
    }

    if @state.hovering and !@hasActiveCommand()
      overlay = div {className: 'attach-files-overlay', @onDragOver, @onDragLeave, onDrop: @onDragDrop},
        Icon {name: 'file'}
        "Drop to attach to this card"
    
    Panel props,
      CardHeader {panelid: @props.id, card: @state.card, kind: @state.kind}
      div {className: 'content'},
        CardOverview {card: @state.card, kind: @state.kind, stack: @state.stack}
        CardBody {card: @state.card, kind: @state.kind, stack: @state.stack}
        CardCommand {command: @getActiveCommand(), card: @state.card, stack: @state.stack}
        overlay
      CardFooter {card: @state.card, kind: @state.kind, stack: @state.stack}

  onDragOver: (event) ->
    return if @hasActiveCommand()
    event.preventDefault()
    event.stopPropagation()

  onDragEnter: (event) ->
    return if @hasActiveCommand()
    event.preventDefault()
    @setState {hovering: true}

  onDragLeave: (event) ->
    return if @hasActiveCommand()
    event.preventDefault()
    @setState {hovering: false}

  onDragDrop: (event) ->
    return if @hasActiveCommand()
    event.preventDefault()
    @setState {hovering: false}
    {files} = event.dataTransfer
    @showCommand(CardCommandType.Attach, {files}) if files?.length > 0

}

module.exports = CardPanel
