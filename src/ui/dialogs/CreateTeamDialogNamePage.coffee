React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
Field        = React.createFactory(require 'ui/common/Field')
FieldGroup   = React.createFactory(require 'ui/common/FieldGroup')
{div, input} = React.DOM

CreateTeamDialogNamePage = React.createClass {

  displayName: 'CreateTeamDialogNamePage'

  props:
    name:     PropTypes.string
    title:    PropTypes.string
    onChange: PropTypes.func

  getInitialState: -> {
    name: @props.name
  }

  render: ->

    FieldGroup {},
      Field {label: 'Name', note: 'ex. Engineering, HR, World Peace Initiative, Secret Project Team'},
        input {ref: 'name', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    state = {name: event.target.value}
    @setState(state)
    @props.onChange(state)

}

module.exports = CreateTeamDialogNamePage
