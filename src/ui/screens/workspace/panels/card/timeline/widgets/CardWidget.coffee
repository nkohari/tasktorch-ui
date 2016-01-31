#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{em}      = React.DOM
#--------------------------------------------------------------------------------

CardWidget = React.createClass {

  displayName: 'CardWidget'

  propTypes:
    card: PropTypes.Card

  render: ->
    em {className: 'card-widget'},
      @props.card?.title or 'a deleted card'

}

module.exports = CardWidget
