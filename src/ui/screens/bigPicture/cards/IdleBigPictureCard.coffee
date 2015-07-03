#--------------------------------------------------------------------------------
_                       = require 'lodash'
moment                  = require 'moment'
React                   = require 'react'
ActionStatus            = require 'data/enums/ActionStatus'
PropTypes               = require 'ui/framework/PropTypes'
CachedState             = require 'ui/framework/mixins/CachedState'
Navigator               = require 'ui/framework/mixins/Navigator'
CardPanelState          = require 'ui/screens/workspace/panels/card/CardPanelState'
Card                    = React.createFactory(require 'ui/common/Card')
CardOwner               = React.createFactory(require 'ui/common/CardOwner')
CardFollowToggle        = React.createFactory(require 'ui/common/CardFollowToggle')
CardLocation            = React.createFactory(require 'ui/common/CardLocation')
BigPictureCardChecklist = React.createFactory(require 'ui/screens/bigPicture/BigPictureCardChecklist')
{a, div}                = React.DOM
#--------------------------------------------------------------------------------

IdleBigPictureCard = React.createClass {

  displayName: 'IdleBigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

  getCachedState: (cache) ->
    kind       = cache('kinds').get(@props.card.kind)
    stack      = cache('stacks').get(@props.card.stack)
    stages     = cache('stagesByKind').get(@props.card.kind)
    checklists = cache('checklistsByCard').get(@props.card.id)
    if checklists?
      actions = _.object _.map checklists, (checklist) -> [checklist.id, cache('actionsByChecklist').get(checklist.id)]
    {kind, stack, stages, checklists, actions}

  render: ->

    Card {className: 'big-picture-card idle', card: @props.card},
      div {className: 'card-summary'},
        CardOwner {card: @props.card} if @props.card?.user? or @props.card?.team?
        div {className: 'card-info'},
          div {className: 'card-widgets'},
            CardLocation {card: @props.card, stack: @state.stack, link: true}
            CardFollowToggle {card: @props.card}
          a {className: 'title', onClick: @showCard},
            @props.card.title or 'Untitled Card'
      @renderActions()

  renderActions: ->
    return unless @state.kind? and @state.checklists? and @state.stages? and @state.actions?
    {checklist, action} = @findNextNotStartedAction()
    return unless checklist? and action?
    stage = _.find @state.stages, (stage) -> stage.id is action.stage
    BigPictureCardChecklist {card: @props.card, kind: @props.kind, checklist, stage, actions: [action]}

  findNextNotStartedAction: ->
    for stageid in @state.kind.stages
      checklist = _.find @state.checklists,            (checklist) -> checklist.stage == stageid
      action    = _.find @state.actions[checklist.id], (action)    -> action.status is ActionStatus.NotStarted
      return {checklist, action} if action?
    return {}

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = IdleBigPictureCard
