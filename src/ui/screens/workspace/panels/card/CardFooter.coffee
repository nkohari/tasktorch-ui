#--------------------------------------------------------------------------------
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
CardCommandBar = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandBar')
{div}          = React.DOM
#--------------------------------------------------------------------------------

CardFooter = React.createClass {

  displayName: 'CardFooter'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stack: PropTypes.Stack

  render: ->

    div {className: 'footer'},
      CardCommandBar {card: @props.card, stack: @props.stack}

}

module.exports = CardFooter
