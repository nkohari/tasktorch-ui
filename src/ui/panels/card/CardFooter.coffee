React             = require 'react'
PropTypes         = require 'framework/PropTypes'
Observe           = require 'framework/mixins/Observe'
Frame             = React.createFactory(require 'ui/common/Frame')
CardFollowersList = React.createFactory(require 'ui/panels/card/CardFollowersList')
CardCommentBox    = React.createFactory(require 'ui/panels/card/CardCommentBox')

CardFooter = React.createClass {

  displayName: 'CardFooter'

  propTypes:
    card: PropTypes.Card

  render: ->

    Frame {className: 'footer'},
      CardCommentBox    {card: @props.card}
      CardFollowersList {card: @props.card}

}

module.exports = CardFooter
