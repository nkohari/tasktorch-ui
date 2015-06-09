_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
classSet           = require 'common/util/classSet'
mergeProps         = require 'common/util/mergeProps'
{div, input, span} = React.DOM

Checkbox = React.createClass {

  displayName: 'Checkbox'

  propTypes:
    text:    PropTypes.string
    checked: PropTypes.bool

  render: ->

    props = mergeProps _.omit(@props, 'text'), {
      ref:     'input'
      type:    'checkbox'
      checked: @props.checked
    }

    div {className: 'input'},
      input props
      span {className: 'input-text'}, @props.text

  focus: ->
    return unless @isMounted()
    @refs.input.getDOMNode().focus()

}

module.exports = Checkbox
