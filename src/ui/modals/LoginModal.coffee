#--------------------------------------------------------------------------------
_                 = require 'lodash'
jstz              = require 'jstz'
superagent        = require 'superagent'
React             = require 'react'
Router            = require 'react-router'
Request           = require 'data/framework/Request'
LoginForm         = require 'ui/forms/LoginForm'
PropTypes         = require 'ui/framework/PropTypes'
Button            = React.createFactory(require 'ui/common/Button')
FormButtons       = React.createFactory(require 'ui/common/FormButtons')
Modal             = React.createFactory(require 'ui/common/Modal')
ModalForm         = React.createFactory(require 'ui/common/ModalForm')
ModalMessage      = React.createFactory(require 'ui/common/ModalMessage')
{a, div, p, span} = React.DOM
#--------------------------------------------------------------------------------

LoginModal = React.createClass {

  displayName: 'LoginModal'

  mixins: [Router.History]

  propTypes:
    query: PropTypes.object

  getInitialState: -> {
    form: new LoginForm {@onChange}
  }

  render: ->

    buttons = FormButtons {},
      Button {type: 'submit', text: 'Log In'}
      #span {className: 'divider'}, "\u2014or\u2014"
      #a {onClick: @onForgotClicked}, "I can't remember!"

    Modal {title: 'Log In', className: 'login-modal'},
      ModalForm {form: @state.form, buttons, @onSubmit}
      @getMessage()

  onChange: ->
    @forceUpdate()

  getMessage: ->
    switch @props.query?.from
      when 'signup'
        ModalMessage {},
          p {}, "Welcome to TaskTorch!"
          p {}, "Your account has been created."
          p {}, "Please log in with the username and password you provided, and we'll get started!"
      when 'invite'
        ModalMessage {},
          p {}, "Welcome back!"
          p {}, "Please log in with your username and password, and we'll add you to the organization."
      when 'invite-accepted'
        ModalMessage {},
          p {}, "Welcome to TaskTorch!"
          p {}, "Your account has been created and you're now a member of the organization."
          p {}, "Please log in with the username and password you provided, and we'll get started!"
      when 'expired'
        ModalMessage {},
          p {}, "Welcome to TaskTorch!"
          p {}, "Your session has expired. Please log in again."
      else
        ModalMessage {},
          p {}, "Welcome back! Please log in."
          p {}, "We'll be open to the public soon. If you don't already have an account, you can join our invite list."

  onForgotClicked: ->

  onSubmit: (event) ->
    
    event.preventDefault()

    return unless @state.form.validate()

    timezone = jstz.determine()
    payload = {
      login:    @state.form.cleanedData.login
      password: @state.form.cleanedData.password
      invite:   @props.query?.invite
      timezone: timezone.name()
    }

    superagent
    .post(Request.urlFor('/sessions'))
    .send(payload)
    .withCredentials()
    .end (err, res) =>
      if res.forbidden
        # TODO
        alert("Username or password incorrect.")
        return
      @redirect()

  redirect: ->
    url = @props.query?.return
    if url?
      document.location = url
    else
      superagent
      .get(Request.urlFor('/me/orgs'))
      .withCredentials()
      .end (err, res) =>
        {orgs} = res.body
        if      orgs.length == 0 then @history.pushState(null, '/orgs/create')
        else if orgs.length == 1 then @history.pushState(null, "/#{orgs[0].id}/workspace")
        else @history.pushState(null, '/orgs')

}

module.exports = LoginModal
