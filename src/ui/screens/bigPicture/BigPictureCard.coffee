#--------------------------------------------------------------------------------
_                        = require 'lodash'
React                    = require 'react'
classSet                 = require 'common/util/classSet'
CardStatus               = require 'data/enums/CardStatus'
PropTypes                = require 'ui/framework/PropTypes'
Navigator                = require 'ui/framework/mixins/Navigator'
CardPanelState           = require 'ui/screens/workspace/panels/card/CardPanelState'
Card                     = React.createFactory(require 'ui/common/Card')
NotStartedBigPictureCard = React.createFactory(require './cards/NotStartedBigPictureCard')
InProgressBigPictureCard = React.createFactory(require './cards/InProgressBigPictureCard')
IdleBigPictureCard       = React.createFactory(require './cards/IdleBigPictureCard')
WarningBigPictureCard    = React.createFactory(require './cards/WarningBigPictureCard')
CompleteBigPictureCard   = React.createFactory(require './cards/CompleteBigPictureCard')
#--------------------------------------------------------------------------------
require './BigPictureCard.styl'
#--------------------------------------------------------------------------------

BigPictureCard = React.createClass {

  displayName: 'BigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'big-picture-card'
      @props.card.status.toLowerCase() if @props.card?
    ]

    Card {className: classes, card: @props.card, onClick: @showCard},
      @renderCardContent()

  renderCardContent: ->

    switch @props.card.status
      when CardStatus.NotStarted then NotStartedBigPictureCard {card: @props.card}
      when CardStatus.InProgress then InProgressBigPictureCard {card: @props.card}
      when CardStatus.Idle       then IdleBigPictureCard       {card: @props.card}
      when CardStatus.Warning    then WarningBigPictureCard    {card: @props.card}
      when CardStatus.Complete   then CompleteBigPictureCard   {card: @props.card}

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = BigPictureCard
