React                  = require 'react'
PropTypes              = require 'ui/framework/PropTypes'
Button                 = React.createFactory(require 'ui/common/Button')
Frame                  = React.createFactory(require 'ui/common/Frame')
CardFollowersList      = React.createFactory(require 'ui/panels/card/CardFollowersList')
FollowCardToggleButton = React.createFactory(require 'ui/panels/card/FollowCardToggleButton')

CardFooter = React.createClass {

  displayName: 'CardFooter'

  propTypes:
    card:        PropTypes.Card
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'footer'},
      Frame {className: 'left-buttons'},
        FollowCardToggleButton {card: @props.card, currentUser: @props.currentUser}
      CardFollowersList {card: @props.card, currentUser: @props.currentUser}
      Frame {className: 'right-buttons'}

}

module.exports = CardFooter
