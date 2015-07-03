#--------------------------------------------------------------------------------
_                        = require 'lodash'
React                    = require 'react'
CardStatus               = require 'data/enums/CardStatus'
PropTypes                = require 'ui/framework/PropTypes'
Navigator                = require 'ui/framework/mixins/Navigator'
NotStartedBigPictureCard = React.createFactory(require 'ui/screens/bigPicture/cards/NotStartedBigPictureCard')
InProgressBigPictureCard = React.createFactory(require 'ui/screens/bigPicture/cards/InProgressBigPictureCard')
IdleBigPictureCard       = React.createFactory(require 'ui/screens/bigPicture/cards/IdleBigPictureCard')
WarningBigPictureCard    = React.createFactory(require 'ui/screens/bigPicture/cards/WarningBigPictureCard')
CompleteBigPictureCard   = React.createFactory(require 'ui/screens/bigPicture/cards/CompleteBigPictureCard')
#--------------------------------------------------------------------------------
require './BigPictureCard.styl'
#--------------------------------------------------------------------------------

BigPictureCard = React.createClass {

  displayName: 'BigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Navigator]

  render: ->

    switch @props.card.status
      when CardStatus.NotStarted then NotStartedBigPictureCard {card: @props.card}
      when CardStatus.InProgress then InProgressBigPictureCard {card: @props.card}
      when CardStatus.Idle       then IdleBigPictureCard       {card: @props.card}
      when CardStatus.Warning    then WarningBigPictureCard    {card: @props.card}
      when CardStatus.Complete   then CompleteBigPictureCard   {card: @props.card}


}

module.exports = BigPictureCard
