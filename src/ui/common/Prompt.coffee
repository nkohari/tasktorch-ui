#--------------------------------------------------------------------------------
React        = require 'react'
mergeClasses = require 'common/util/mergeClasses'
Hints        = require 'config/Hints'
PropTypes    = require 'ui/framework/PropTypes'
{div}        = React.DOM
#--------------------------------------------------------------------------------
require './Prompt.styl'
#--------------------------------------------------------------------------------

Prompt = React.createClass {

  displayName: 'Prompt'

  props:
    label: PropTypes.node
    hint:  PropTypes.node

  getInitialState: ->
    {focused: false}

  render: ->

    classes = mergeClasses('prompt', @props.className)
    div {className: classes, @onFocus, @onBlur},
      div {className: 'prompt-text'},
        @props.children
      div {className: 'hint'}, Hints[@props.hint] if @props.hint?

}

module.exports = Prompt
