#--------------------------------------------------------------------------------
_                        = require 'lodash'
React                    = require 'react'
classSet                 = require 'common/util/classSet'
CardStatus               = require 'data/enums/CardStatus'
UserOpenedPanelEvent     = require 'events/ui/UserOpenedPanelEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
CardPanelSpec            = require 'ui/framework/panels/CardPanelSpec'
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

  mixins: [Actor]

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
    @publish new UserOpenedPanelEvent(new CardPanelSpec(@props.card.id), {screen: 'workspace'})

}

module.exports = BigPictureCard
