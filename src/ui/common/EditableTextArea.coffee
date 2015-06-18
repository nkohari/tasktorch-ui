#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
KeyCode    = require 'ui/framework/KeyCode'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
TextArea   = React.createFactory(require 'ui/common/TextArea')
#--------------------------------------------------------------------------------
require './Editable.styl'
#--------------------------------------------------------------------------------

EditableTextArea = React.createClass {

  displayName: 'EditableTextArea'

  propTypes:
    value: PropTypes.any

  getInitialState: ->
    {dirty: false, previous: undefined, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  render: ->

    classes = classSet [
      'editable'
      'dirty' if @state.dirty
    ]

    props = mergeProps _.omit(@props, 'value'), {
      ref: 'textarea'
      className: classes
      value: @state.value
      @onChange
      @onFocus
      @onBlur
      @onKeyUp
    }

    TextArea props

  focus: ->
    return unless @isMounted()
    @refs.textarea.focus()

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @refs.textarea.blur()
      when KeyCode.RETURN
        if event.shiftKey
          @refs.textarea.blur()

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}
    @props.onChange(event) if @props.onChange?

  onFocus: ->
    @setState {previous: @state.value}

  onBlur: ->
    @props.save(@state.value) if @props.save? and @state.dirty
    @setState {dirty: false}

}

module.exports = EditableTextArea
