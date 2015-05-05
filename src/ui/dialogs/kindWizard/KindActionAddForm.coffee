_         = require 'lodash'
React     = require 'react'
KeyCode   = require 'ui/framework/KeyCode'
PropTypes = require 'ui/framework/PropTypes'
Input     = React.createFactory(require 'ui/common/Input')
Icon      = React.createFactory(require 'ui/common/Icon')
{a, div}  = React.DOM

KindActionAddForm = React.createClass {

  displayName: 'KindActionAddForm'

  propTypes:
    stage:     PropTypes.object
    addAction: PropTypes.func

  getInitialState: ->
    {text: ''}

  render: ->

    div {className: 'add-action'},
      Input {
        ref: 'input'
        className: 'action-text'
        value: @state.text
        placeholder: "Add another #{@props.stage.name} action"
        @onKeyUp
        @onChange
      }

  focus: ->
    @refs.input.focus()

  onKeyUp: (event) ->
    if event.which is KeyCode.RETURN
      @addAction()

  onChange: (event) ->
    @setState {text: event.target.value}

  addAction: ->
    return unless @state.text?.length > 0
    @props.addAction(@props.stage.id, {
      id:   new Date().valueOf().toString()
      text: @state.text
    })
    @setState {text: ''}

}

module.exports = KindActionAddForm