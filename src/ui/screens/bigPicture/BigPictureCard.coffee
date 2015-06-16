_                       = require 'lodash'
moment                  = require 'moment'
React                   = require 'react'
CardStatus              = require 'data/enums/CardStatus'
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

BigPictureCard = React.createClass {

  displayName: 'BigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

  getCachedState: (cache) ->
    kind       = cache('kinds').get(@props.card.kind)
    stack      = cache('stacks').get(@props.card.stack) if @props.card.stack?
    stages     = cache('stagesByKind').get(@props.card.kind)
    checklists = cache('checklistsByCard').get(@props.card.id)
    {kind, stack, stages, checklists}

  render: ->

    if (@props.card.status == CardStatus.InProgress or @props.card.status == CardStatus.Warning) and @state.checklists? and @state.stages?
      lookup = _.indexBy(@state.stages, 'id')
      checklists = _.map @state.checklists, (checklist) =>
        stage = lookup[checklist.stage]
        BigPictureCardChecklist {key: checklist.id, card: @props.card, kind: @props.kind, checklist, stage}
      actions = div {className: 'card-actions'},
        checklists

    Card {className: 'big-picture-card', card: @props.card},
      div {className: 'card-summary'},
        CardOwner {card: @props.card} if @props.card?.user? or @props.card?.team?
        div {className: 'card-info'},
          div {className: 'card-widgets'},
            CardLocation {card: @props.card, stack: @state.stack, link: true}
            CardFollowToggle {card: @props.card}
          a {className: 'title', onClick: @showCard},
            @props.card.title or 'Untitled Card'
      actions


  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = BigPictureCard
