_                  = require 'lodash'
React              = require 'react'
classSet           = require 'common/util/classSet'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
CardPanelState     = require 'ui/screens/workspace/panels/card/CardPanelState'
Card               = React.createFactory(require 'ui/common/Card')
CardFollowToggle   = React.createFactory(require 'ui/common/CardFollowToggle')
CardLink           = React.createFactory(require 'ui/common/CardLink')
CardLocation       = React.createFactory(require 'ui/common/CardLocation')
CardOwner          = React.createFactory(require 'ui/common/CardOwner')
StackName          = React.createFactory(require 'ui/common/StackName')
StageCardChecklist = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCardChecklist')
{div, li}          = React.DOM

StageCard = React.createClass {

  displayName: 'StageCard'

  propTypes:
    card:  PropTypes.Card
    stage: PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) ->
    checklists = cache('checklistsByCard').get(@props.card.id)
    return {
      checklist: _.find(checklists, (checklist) => checklist.stage == @props.stage.id)
      user:      cache('users').get(@props.card.user)   if @props.card.user?
      team:      cache('teams').get(@props.card.team)   if @props.card.team?
      stack:     cache('stacks').get(@props.card.stack) if @props.card.stack?
    }

  render: ->

    if @state.checklist?
      checklist = StageCardChecklist {card: @props.card, stage: @props.stage, checklist: @state.checklist}

    Card {className: 'big-picture-card', card: @props.card},
      div {className: 'card-summary'},
        CardOwner {user: @state.user, team: @state.team}
        div {className: 'card-info'},
          div {className: 'title'}, @props.card.title or 'Untitled Card'
          CardLocation {card: @props.card, stack: @state.stack, link: true}
        div {className: 'controls'},
          CardFollowToggle {card: @props.card}
          CardLink {card: @props.card}
      checklist

}

module.exports = StageCard
