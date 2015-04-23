_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
KeyCode    = require 'ui/framework/KeyCode'
mergeProps = require 'common/util/mergeProps'
classSet   = require 'common/util/classSet'
Input      = React.createFactory(require 'ui/common/Input')

EditableInput = React.createClass {

  displayName: 'EditableInput'

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
      ref: 'input'
      className: classes
      value: @state.value
      @onChange
      @onFocus
      @onBlur
      @onKeyUp
    }

    Input props

  focus: ->
    return unless @isMounted()
    @refs.input.focus()

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @refs.input.blur()
      when KeyCode.RETURN
        @refs.input.blur()

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}

  onFocus: ->
    @setState {previous: @state.value}

  onBlur: ->
    @props.save(@state.value) if @state.dirty
    @setState {dirty: false}

}

module.exports = EditableInput
