#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
{a, div}         = React.DOM
#--------------------------------------------------------------------------------

CompleteBigPictureCard = React.createClass {

  displayName: 'CompleteBigPictureCard'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: 'card-content'},
      div {className: 'card-summary'},
        div {className: 'card-info'},
          div {className: 'card-widgets'},
            CardFollowToggle {card: @props.card}
          div {className: 'title'},
            @props.card.title or 'Untitled Card'

}

module.exports = CompleteBigPictureCard
