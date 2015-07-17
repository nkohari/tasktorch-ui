#--------------------------------------------------------------------------------
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
{li, span} = React.DOM
#--------------------------------------------------------------------------------
require './OptionListSeparator.styl'
#--------------------------------------------------------------------------------

OptionListSeparator = React.createClass {

  displayName: 'OptionListSeparator'

  propTypes:
    text: PropTypes.string

  render: ->

    if @props.text
      li {className: 'option-list-separator'},
        span {className: 'text'}, @props.text

}

module.exports = OptionListSeparator
