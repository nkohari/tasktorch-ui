_             = require 'lodash'
React         = require 'react'
CardStatus    = require 'data/enums/CardStatus'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
Icon          = React.createFactory(require 'ui/common/Icon')
BigPictureCard = React.createFactory(require 'ui/screens/bigPicture/BigPictureCard')
{div, ul}     = React.DOM

GoalPanelColumnSection = React.createClass {

  displayName: 'GoalPanelColumnSection'

  propTypes:
    goal:   PropTypes.Goal
    kind:   PropTypes.Kind
    status: PropTypes.enum(CardStatus)
    cards:  PropTypes.arrayOf(PropTypes.Card)

  render: ->

    count  = @props.cards.length or 0
    plural = if count == 1 then '' else 's'

    cards = _.map @props.cards, (card) =>
      BigPictureCard {key: card.id, card, goal: @props.goal, kind: @props.kind}

    div {className: 'big-picture-column-section'},
      div {className: 'header'},
        div {className: 'name'},
          Icon {name: @props.status.toLowerCase()}
          @getName()
        div {className: 'count'}, "#{count} card#{plural}"
      ul {className: 'cards'}, cards

  getName: ->
    switch @props.status
      when CardStatus.NotStarted then 'Not Started'
      when CardStatus.InProgress then 'In Progress'
      when CardStatus.Warning    then 'Warning'
      when CardStatus.Complete   then 'Complete'

}

module.exports = GoalPanelColumnSection
