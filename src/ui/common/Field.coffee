#--------------------------------------------------------------------------------
React        = require 'react'
classSet     = require 'common/util/classSet'
mergeClasses = require 'common/util/mergeClasses'
Hints        = require 'config/Hints'
PropTypes    = require 'ui/framework/PropTypes'
{div, label} = React.DOM
#--------------------------------------------------------------------------------
require './Field.styl'
#--------------------------------------------------------------------------------

Field = React.createClass {

  displayName: 'Field'

  props:
    label:        PropTypes.node
    hint:         PropTypes.node
    hintPosition: PropTypes.string
    expand:       PropTypes.bool

  getDefaultProps: ->
    {expand: false, hintPosition: 'after'}

  render: ->

    classes = mergeClasses(classSet [
      'field'
      'expand' if @props.expand
    ], @props.className)

    div {className: classes},
      label {className: 'field-label'}, @props.label
      div   {className: 'hint'},        Hints[@props.hint] if @props.hint? and @props.hintPosition is 'before'
      div   {className: 'field-input'}, @props.children
      div   {className: 'hint'},        Hints[@props.hint] if @props.hint? and @props.hintPosition is 'after'

}

module.exports = Field
