_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
{div, input, button} = React.DOM

# TODO: This needs to be replaced by a real solution.
CreateUserScreen = React.createClass {

  displayName: 'CreateUserScreen'

  mixins: [Router.Navigation]

  render: ->
    div {className: 'login screen'}, [
      input {type: 'text',     name: 'username', placeholder: 'Username',     onChange: @handleChange('username')}
      input {type: 'password', name: 'password', placeholder: 'Password',     onChange: @handleChange('password')}
      input {type: 'text',     name: 'name',     placeholder: 'Name',         onChange: @handleChange('name')}
      input {type: 'text',     name: 'email',    placeholder: 'Email',        onChange: @handleChange('email')}
      input {type: 'text',     name: 'token',    placeholder: 'Invite Token', onChange: @handleChange('token')}
      button {onClick: @handleSubmitClicked}, ['Create User']
    ]

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

module.exports = CreateUserScreen
