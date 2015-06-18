#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
classSet           = require 'common/util/classSet'
mergeProps         = require 'common/util/mergeProps'
{div, input, span} = React.DOM
#--------------------------------------------------------------------------------

Radio = React.createClass {

  displayName: 'Radio'

  propTypes:
    name:  PropTypes.string
    text:  PropTypes.string
    value: PropTypes.any

  render: ->

    props = mergeProps _.omit(@props, 'text'), {
      ref:   'input'
      type:  'radio'
      name:  @props.name
      value: @props.value
    }

    div {className: 'radio input', @onClick},
      input props
      span {className: 'input-text'}, @props.text

  onClick: (event) ->
    @refs.input.getDOMNode().click()
    return

  focus: ->
    return unless @isMounted()
    @refs.input.getDOMNode().focus()

}

module.exports = Radio
