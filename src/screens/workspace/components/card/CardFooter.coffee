React             = require 'react'
PropTypes         = require 'common/PropTypes'
Observe           = require 'mixins/Observe'
Icon              = React.createFactory(require 'common/Icon')
Button            = React.createFactory(require 'common/Button')
CardFollowersList = React.createFactory(require './CardFollowersList')
CardCommentBox    = React.createFactory(require './CardCommentBox')
{div}             = React.DOM

CardFooter = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'CardFooter'

  propTypes:
    card: PropTypes.Card

  #--------------------------------------------------------------------------------

  render: ->
    div {className: 'footer'}, [
      CardCommentBox    {key: 'comment',   card: @props.card}
      CardFollowersList {key: 'followers', card: @props.card}
    ]

  #--------------------------------------------------------------------------------
}

module.exports = CardFooter
