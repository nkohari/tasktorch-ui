React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
Field        = React.createFactory(require 'ui/common/Field')
FieldGroup   = React.createFactory(require 'ui/common/FieldGroup')
{div, input} = React.DOM

CreateTeamDialogNamePage = React.createClass {

  displayName: 'CreateTeamDialogNamePage'

  props:
    name:     PropTypes.string
    purpose:  PropTypes.string
    title:    PropTypes.string
    onChange: PropTypes.func

  getInitialState: -> {
    name:    @props.name
    purpose: @props.purpose
  }

  componentDidMount: ->
    @refs.name.getDOMNode().focus()

  render: ->

    FieldGroup {},
      Field {label: 'Name', note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team'},
        input {ref: 'name', value: @state.name, onChange: @onNameChanged}
      Field {label: 'Purpose', note: 'ex. Product Development, Customer Happiness, World Domination'},
        input {ref: 'purpose', value: @state.purpose, onChange: @onPurposeChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    state = {name: event.target.value}
    @setState(state)
    @props.onChange(state)

  onPurposeChanged: (event) ->
    state = {purpose: event.target.value}
    @setState(state)
    @props.onChange(state)

}

module.exports = CreateTeamDialogNamePage
