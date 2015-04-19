_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
Field      = React.createFactory(require 'ui/common/Field')
FieldGroup = React.createFactory(require 'ui/common/FieldGroup')
Icon       = React.createFactory(require 'ui/common/Icon')
{div, input, button} = React.DOM

LoginInterstitial = React.createClass {

  displayName: 'LoginInterstitial'

  mixins: [Router.Navigation]

  getInitialState: ->
    {login: undefined, password: undefined}

  render: ->
    div {className: 'login interstitial'},
      div {className: 'login-form'},
        FieldGroup {},
          Field {label: Icon {name: 'user'}},
            input {type: 'text', name: 'login', placeholder: 'Username or email', onChange: @handleLoginChange}
          Field {label: Icon {name: 'secure'}},
            input {type: 'password', name: 'password', placeholder: 'Password', onChange: @handlePasswordChange}
        div {className: 'buttons'},
          button {onClick: @handleSubmitClicked}, 'Log In'
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Private Alpha'

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

module.exports = LoginInterstitial
