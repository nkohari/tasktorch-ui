_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Navigator          = require 'ui/framework/mixins/Navigator'
CardPanelState     = require 'ui/screens/workspace/panels/card/CardPanelState'
Avatar             = React.createFactory(require 'ui/common/Avatar')
Link               = React.createFactory(require 'ui/common/Link')
Icon               = React.createFactory(require 'ui/common/Icon')
StackName          = React.createFactory(require 'ui/common/StackName')
StageCardChecklist = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCardChecklist')
{div, li}          = React.DOM

StageCard = React.createClass {

  displayName: 'StageCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    kind:       cache('kinds').get(@props.card.kind)
    checklists: cache('checklistsByCard').get(@props.card.id)
    stages:     cache('stagesByKind').get(@props.card.kind)
    user:       cache('users').get(@props.card.user) if @props.card.user?
    stack:      cache('stacks').get(@props.card.stack) if @props.card.stack?
  }

  render: ->

    style = {borderLeftColor: @state.kind?.color}

    if @state.checklists? and @state.stages? and @state.kind?
      lookup = _.indexBy(@state.stages, 'id')
      checklists = _.map @state.checklists, (checklist) =>
        stage = lookup[checklist.stage]
        StageCardChecklist {key: checklist.id, card: @props.card, kind: @state.kind, checklist, stage}

    li {},
      Link {className: 'stage-card', style, onClick: @showCard},
        div {className: 'description'},
          Avatar {className: 'stage-card-owner', user: @state.user}
          div {className: 'title'}, @props.card.title or 'Untitled Card'
          div {className: 'stack'},
            Icon      {name: "stack-#{@state.stack?.type.toLowerCase()}"}
            StackName {stack: @state.stack}
        div {className: 'actions'},
          checklists

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = StageCard
