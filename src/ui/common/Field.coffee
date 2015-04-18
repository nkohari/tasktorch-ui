React              = require 'react/addons'
mergeClasses       = require 'common/util/mergeClasses'
PropTypes          = require 'ui/framework/PropTypes'
{div, span, label} = React.DOM
{cloneWithProps}   = React.addons

Field = React.createClass {

  displayName: 'Field'

  props:
    label: PropTypes.node
    note:  PropTypes.node

  getInitialState: ->
    {focused: false}

  render: ->

    if @props.note? and @state.focused
      note = span {className: 'field-note'}, @props.note

    classes = mergeClasses('field', @props.className)

    div {className: classes, @onFocus, @onBlur},
      label {className: 'field-label'},
        @props.label
        note
      div {className: 'field-input'},
        @props.children

  onFocus: ->
    @setState {focused: true}

  onBlur: ->
    @setState {focused: false}

}

module.exports = Field
