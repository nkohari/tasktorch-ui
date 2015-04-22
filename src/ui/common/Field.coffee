React        = require 'react'
classSet     = require 'common/util/classSet'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
{div, label} = React.DOM

Field = React.createClass {

  displayName: 'Field'

  props:
    label:  PropTypes.node
    hint:   PropTypes.node
    expand: PropTypes.bool

  getDefaultProps: ->
    {expand: false}

  render: ->

    classes = mergeClasses(classSet [
      'field'
      'expand' if @props.expand
    ], @props.className)

    div {className: classes},
      label {className: 'field-label'}, @props.label
      div   {className: 'field-input'}, @props.children
      div   {className: 'hint'},        @props.hint if @props.hint?

}

module.exports = Field
