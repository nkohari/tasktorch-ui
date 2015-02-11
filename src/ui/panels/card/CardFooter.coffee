React             = require 'react'
PropTypes         = require 'framework/PropTypes'
Observe           = require 'framework/mixins/Observe'
Icon              = React.createFactory(require 'ui/common/Icon')
Button            = React.createFactory(require 'ui/common/Button')
CardFollowersList = React.createFactory(require 'ui/panels/card/CardFollowersList')
CardCommentBox    = React.createFactory(require 'ui/panels/card/CardCommentBox')
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
