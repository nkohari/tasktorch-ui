#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Navigator        = require 'ui/framework/mixins/Navigator'
CardPanelState   = require 'ui/screens/workspace/panels/card/CardPanelState'
Card             = React.createFactory(require 'ui/common/Card')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
{a, div}         = React.DOM
#--------------------------------------------------------------------------------

CompleteBigPictureCard = React.createClass {

  displayName: 'CompleteBigPictureCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Navigator]

  render: ->

    Card {className: 'big-picture-card complete', card: @props.card},
      div {className: 'card-summary'},
        div {className: 'card-info'},
          div {className: 'card-widgets'},
            CardFollowToggle {card: @props.card}
          a {className: 'title', onClick: @showCard},
            @props.card.title or 'Untitled Card'

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = CompleteBigPictureCard
