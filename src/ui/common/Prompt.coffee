React        = require 'react/addons'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
{div}        = React.DOM

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
      div {className: 'hint'}, @props.hint if @props.hint?

}

module.exports = Prompt
