React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
{div, label} = React.DOM

Field = React.createClass {

  displayName: 'Field'

  props:
    label: PropTypes.string
    note:  PropTypes.node

  render: ->

    if @props.note?
      note = div {className: 'field-note'}, @props.note

    div {className: 'field'},
      label {className: 'field-label'}, @props.label
      div {className: 'field-input'},
        @props.children
        note

}

module.exports = Field
