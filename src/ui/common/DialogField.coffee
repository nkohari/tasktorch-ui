React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
{div, label, input} = React.DOM

DialogField = React.createClass {

  displayName: 'DialogField'

  props:
    name:     PropTypes.string
    note:     PropTypes.node
    value:    PropTypes.string
    onChange: PropTypes.func

  render: ->

    div {className: 'field'},
      label {className: 'field-label'}, @props.name
      div {className: 'field-input'},
        input {ref: 'input', name: @props.name, value: @props.value, onChange: @props.onChange}
        div {className: 'field-note'}, @props.note

  focus: ->
    return unless @isMounted()
    node = @refs.input.getDOMNode()
    node.focus()
    node.select()

}

module.exports = DialogField
