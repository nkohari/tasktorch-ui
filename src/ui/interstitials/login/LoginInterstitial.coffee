_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
Button     = React.createFactory(require 'ui/common/Button')
Field      = React.createFactory(require 'ui/common/Field')
Input      = React.createFactory(require 'ui/common/Input')
{div}      = React.DOM

LoginInterstitial = React.createClass {

  displayName: 'LoginInterstitial'

  mixins: [Router.Navigation]

  getInitialState: ->
    {login: undefined, password: undefined}

  componentDidMount: ->
    document.title = "TaskTorch | Log In"
    @refs.login.focus()

  render: ->

    div {className: 'login interstitial'},
      div {className: 'login-form'},
        Field {label: 'Username or Email'},
          Input {ref: 'login', icon: 'user', value: @state.login, onChange: @handleLoginChange}
        Field {label: 'Password'},
          Input {type: 'password', icon: 'secure', value: @state.password, onChange: @handlePasswordChange}
        div {className: 'buttons'},
          Button {text: 'Log In', onClick: @handleSubmitClicked}
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
        if orgs.length == 1
          @transitionTo('workspace', {orgid: orgs[0].id})
        else
          @transitionTo('orglist')

}

module.exports = LoginInterstitial
