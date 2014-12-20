React            = require 'react'
PropTypes        = require 'common/PropTypes'
Observe          = require 'mixins/Observe'
Icon             = React.createFactory(require 'common/Icon')
Button           = React.createFactory(require 'common/Button')
CardParticipants = React.createFactory(require './CardParticipants')
{div, textarea}  = React.DOM

CardFooter = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'CardFooter'

  propTypes:
    card: PropTypes.Card

  #--------------------------------------------------------------------------------

  render: ->
    div {className: 'footer'}, [
      CardParticipants {key: 'participants', card: @props.card}
      div {key: 'buttons', className: 'button-group right'}, [
        Button {key: 'add-comment', icon: 'add-comment'}
        Button {key: 'add-file', icon: 'add-file'}
      ]
    ]

  #--------------------------------------------------------------------------------
}

module.exports = CardFooter
