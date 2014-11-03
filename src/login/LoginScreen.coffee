_       = require 'lodash'
Api     = require '../Api'
React   = require 'react/addons'
Router  = require 'react-router'
request = require 'superagent'
{div, input, button} = React.DOM

LoginScreen = React.createClass {

  displayName: 'LoginScreen'

  mixins: [Router.Navigation]

  getInitialState: ->
    {login: undefined, password: undefined}

  render: ->
    div {className: 'login screen'}, [
      input {type: 'text',     name: 'login',    onChange: @handleLoginChange}
      input {type: 'password', name: 'password', onChange: @handlePasswordChange}
      button {onClick: @handleSubmitClicked}, ['Log In']
    ]

  handleLoginChange: (event) ->
    @setState {login: event.target.value}

  handlePasswordChange: (event) ->
    @setState {password: event.target.value}

  handleSubmitClicked: ->
    Api.createSession @state.login, @state.password, (res) =>
      # TODO: Proper validation
      return alert('nope') if res.forbidden
      Api.getMyOrganizations (res) =>
        # TODO: Present the user with a choice of organizations, or go to the most-recent,
        # instead of always going to the first.
        organizations = res.body
        @transitionTo('workspace', {organizationId: organizations[0].id})

}

module.exports = LoginScreen
