_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
KeyCode    = require 'data/enums/KeyCode'
mergeProps = require 'common/util/mergeProps'
classSet   = require 'common/util/classSet'
{input}    = React.DOM

EditableText = React.createClass {

  displayName: 'EditableText'

  propTypes:
    value: PropTypes.any

  getInitialState: ->
    {dirty: false, previous: @props.value, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  render: ->

    classes = classSet [
      'editable'
      'dirty' if @state.dirty
    ]

    props = mergeProps _.omit(@props, 'value'), {
      className: classes
      value: @state.value
      @onChange
      @onFocus
      @onBlur
      @onKeyUp
    }

    input props

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @getDOMNode().blur()
      when KeyCode.RETURN
        @getDOMNode().blur()

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}

  onFocus: ->
    @setState {previous: @state.value}

  onBlur: ->
    @props.save(@state.value) if @state.dirty
    @setState {dirty: false}

}

module.exports = EditableText
