#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------
require './DialogFooter.styl'
#--------------------------------------------------------------------------------

DialogFooter = React.createClass {

  displayName: 'DialogFooter'

  propTypes:
    left:  PropTypes.node
    right: PropTypes.node

  render: ->

    div {className: 'dialog-footer'},
      div {className: 'dialog-footer-left'},  @props.left  if @props.left?
      div {className: 'dialog-footer-right'}, @props.right if @props.right?

}

module.exports = DialogFooter
