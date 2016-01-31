#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
ActionStatus            = require 'data/enums/ActionStatus'
PropTypes               = require 'ui/framework/PropTypes'
CachedState             = require 'ui/framework/mixins/CachedState'
CardOwner               = React.createFactory(require 'ui/common/CardOwner')
CardFollowToggle        = React.createFactory(require 'ui/common/CardFollowToggle')
CardLocation            = React.createFactory(require 'ui/common/CardLocation')
BigPictureCardChecklist = React.createFactory(require 'ui/screens/bigPicture/BigPictureCardChecklist')
{a, div}                = React.DOM
#--------------------------------------------------------------------------------

WarningBigPictureCard = React.createClass {

  displayName: 'WarningBigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) ->
    kind       = cache('kinds').get(@props.card.kind)
    stack      = cache('stacks').get(@props.card.stack) if @props.card.stack?
    stages     = cache('stagesByKind').get(@props.card.kind)
    checklists = cache('checklistsByCard').get(@props.card.id)
    if checklists?
      actions = _.fromPairs _.map checklists, (checklist) -> [checklist.id, cache('actionsByChecklist').get(checklist.id)]
    {kind, stack, stages, checklists, actions}

  render: ->

    div {className: 'card-content'},
      div {className: 'card-summary'},
        CardOwner {card: @props.card} if @props.card?.user? or @props.card?.team?
        div {className: 'card-info'},
          div {className: 'card-widgets'},
            CardLocation {card: @props.card, stack: @state.stack, link: true}
            CardFollowToggle {card: @props.card}
          div {className: 'title'},
            @props.card.title or 'Untitled Card'
      @renderActions()

  renderActions: ->
    return unless @state.kind? and @state.checklists? and @state.stages? and @state.actions?
    actions = _.map @state.kind.stages, (stageid) =>
      stage     = _.find @state.stages,     (stage)     -> stage.id == stageid
      checklist = _.find @state.checklists, (checklist) -> checklist.stage == stageid
      actions   = _.filter @state.actions[checklist.id], (action) -> action.status == ActionStatus.InProgress or action.status == ActionStatus.Warning
      BigPictureCardChecklist {card: @props.card, kind: @props.kind, checklist, stage, actions}
    div {className: 'card-actions'}, actions

}

module.exports = WarningBigPictureCard
