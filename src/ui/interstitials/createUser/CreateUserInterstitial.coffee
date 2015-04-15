_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
PropTypes  = require 'ui/framework/PropTypes'
Field      = React.createFactory(require 'ui/common/Field')
FieldGroup = React.createFactory(require 'ui/common/FieldGroup')
Icon       = React.createFactory(require 'ui/common/Icon')
{div, input, button} = React.DOM

CreateUserInterstitial = React.createClass {

  displayName: 'CreateUserInterstitial'

  propTypes:
    url: PropTypes.object

  mixins: [Router.Navigation]

  getInitialState: ->
    {token: @props.url.query?.token}

  render: ->
    div {className: 'create-user interstitial'},
      div {className: 'create-user-form'},
        FieldGroup {},
          Field {label: 'Username'},
            input {type: 'text', name: 'username', value: @state.username, placeholder: 'Username', onChange: @handleChange('username')}
          Field {label: 'Password'},
            input {type: 'password', name: 'password', value: @state.password, placeholder: 'Password', onChange: @handleChange('password')}
          Field {label: 'Name'},
            input {type: 'text', name: 'name', value: @state.name, placeholder: 'Name', onChange: @handleChange('name')}
          Field {label: 'Email'},
            input {type: 'text', name: 'email', value: @state.email, placeholder: 'Email', onChange: @handleChange('email')}
          Field {label: 'Invite Token'},
            input {type: 'text', name: 'token', value: @state.token, placeholder: 'Invite Token', onChange: @handleChange('token')}
        div {className: 'buttons'},
          button {onClick: @handleSubmitClicked}, 'Create Account'

  handleChange: (field) ->
    return (event) =>
      patch = {}
      patch[field] = event.target.value
      @setState(patch)

  handleSubmitClicked: ->
    superagent.post('/api/users').send(@state).end (res) =>
      if res.forbidden or res.badRequest
        alert("Error creating user")
        return
      @transitionTo('login')

}

module.exports = CreateUserInterstitial
