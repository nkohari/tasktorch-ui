#--------------------------------------------------------------------------------
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
{li, span} = React.DOM
#--------------------------------------------------------------------------------
require './ContextMenuSeparator.styl'
#--------------------------------------------------------------------------------

ContextMenuSeparator = React.createClass {

  displayName: 'ContextMenuSeparator'

  propTypes:
    text: PropTypes.string

  render: ->

    if @props.text
      li {className: 'menu-separator'},
        span {className: 'text'}, @props.text
    else
      li {className: 'menu-separator-line'}

}

module.exports = ContextMenuSeparator
