_          = require 'lodash'
superagent = require 'superagent'
React      = require 'react/addons'
Router     = require 'react-router'
request    = require 'superagent'
PropTypes  = require 'ui/framework/PropTypes'
Request    = require 'data/framework/Request'
Button     = React.createFactory(require 'ui/common/Button')
Field      = React.createFactory(require 'ui/common/Field')
Input      = React.createFactory(require 'ui/common/Input')
{div}      = React.DOM

InviteInterstitial = React.createClass {

  displayName: 'InviteInterstitial'

  propTypes:
    url: PropTypes.object

  mixins: [Router.Navigation]

  getInitialState: ->
    {token: @props.url.query?.token}

  componentDidMount: ->
    document.title = "TaskTorch | Accept Invitation"

  render: ->

    div {className: 'invite interstitial'},
      div {className: 'accept-invite-form'},
        Field {label: 'Username'},
          Input {type: 'text', name: 'username', value: @state.username, placeholder: 'Username', onChange: @handleChange('username')}
        Field {label: 'Password'},
          Input {type: 'password', name: 'password', value: @state.password, placeholder: 'Password', onChange: @handleChange('password')}
        Field {label: 'Name'},
          Input {type: 'text', name: 'name', value: @state.name, placeholder: 'Name', onChange: @handleChange('name')}
        Field {label: 'Email'},
          Input {type: 'text', name: 'email', value: @state.email, placeholder: 'Email', onChange: @handleChange('email')}
        Field {label: 'Invite Token'},
          Input {type: 'text', name: 'token', value: @state.token, placeholder: 'Invite Token', onChange: @handleChange('token')}
        div {className: 'buttons'},
          Button {text: 'Create Account', onClick: @handleSubmitClicked}

  handleChange: (field) ->
    return (event) =>
      patch = {}
      patch[field] = event.target.value
      @setState(patch)

  handleSubmitClicked: ->
    superagent
    .post(Request.urlFor('/users'))
    .send(@state).end (err, res) =>
      if res.forbidden or res.badRequest
        alert("Error creating user")
        return
      @transitionTo('login')

}

module.exports = InviteInterstitial
