React        = require 'react'
mergeClasses = require 'common/util/mergeClasses'
PropTypes    = require 'ui/framework/PropTypes'
{div, label} = React.DOM

Field = React.createClass {

  displayName: 'Field'

  props:
    label: PropTypes.node
    hint:  PropTypes.node

  render: ->

    classes = mergeClasses('field', @props.className)
    div {className: classes},
      label {className: 'field-label'}, @props.label
      div   {className: 'field-input'}, @props.children
      div   {className: 'hint'},        @props.hint if @props.hint?

}

module.exports = Field
