React                  = require 'react'
PropTypes              = require 'ui/framework/PropTypes'
Button                 = React.createFactory(require 'ui/common/Button')
CardFollowersList      = React.createFactory(require 'ui/screens/workspace/panels/card/CardFollowersList')
FollowCardToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/FollowCardToggleButton')
{div}                  = React.DOM

CardFooter = React.createClass {

  displayName: 'CardFooter'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  render: ->

    div {className: 'card-footer'},
      div {className: 'left-buttons'},
        FollowCardToggleButton {card: @props.card, currentUser: @props.currentUser}
      CardFollowersList {card: @props.card, currentUser: @props.currentUser}
      div {className: 'right-buttons'}

}

module.exports = CardFooter
