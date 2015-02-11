_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
{div, input, button} = React.DOM

# TODO: This needs to be replaced by a real solution.
LoginScreen = React.createClass {

  displayName: 'LoginScreen'

  mixins: [Router.Navigation]

  getInitialState: ->
    {login: undefined, password: undefined}

  render: ->
    div {className: 'login screen'}, [
      input {type: 'text', name: 'login', placeholder: 'Login', onChange: @handleLoginChange}
      input {type: 'password', name: 'password', placeholder: 'Password', onChange: @handlePasswordChange}
      button {onClick: @handleSubmitClicked}, ['Log In']
    ]

  handleLoginChange: (event) ->
    @setState {login: event.target.value}

  handlePasswordChange: (event) ->
    @setState {password: event.target.value}

  handleSubmitClicked: ->
    payload = {login: @state.login, password: @state.password}
    superagent.post('/api/sessions').send(payload).end (res) =>
      if res.forbidden
        alert("Username or password incorrect")
        return
      superagent.get('/api/me/orgs').end (res) =>
        {orgs} = res.body
        @transitionTo('workspace', {orgid: orgs[0].id})

}

module.exports = LoginScreen
