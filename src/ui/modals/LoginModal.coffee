#--------------------------------------------------------------------------------
_                 = require 'lodash'
superagent        = require 'superagent'
React             = require 'react'
Router            = require 'react-router'
Request           = require 'data/framework/Request'
LoginForm         = require 'ui/forms/LoginForm'
Button            = React.createFactory(require 'ui/common/Button')
FormButtons       = React.createFactory(require 'ui/common/FormButtons')
Modal             = React.createFactory(require 'ui/common/Modal')
ModalForm         = React.createFactory(require 'ui/common/ModalForm')
ModalMessage      = React.createFactory(require 'ui/common/ModalMessage')
{a, div, p, span} = React.DOM
#--------------------------------------------------------------------------------

LoginModal = React.createClass {

  displayName: 'LoginModal'

  mixins: [Router.Navigation]

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
    switch @props.url.query?.from
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
      else
        ModalMessage {},
          p {}, "Welcome back! Please log in."
          p {}, "We'll be open to the public soon. If you don't already have an account, you can join our invite list."

  onForgotClicked: ->

  onSubmit: (event) ->
    
    event.preventDefault()

    return unless @state.form.validate()

    payload =
      login:    @state.form.cleanedData.login
      password: @state.form.cleanedData.password
      invite:   @props.url.query?.invite

    superagent
    .post(Request.urlFor('/sessions'))
    .send(payload)
    .withCredentials()
    .end (err, res) =>
      if res.forbidden
        # TODO
        alert("Username or password incorrect.")
        return
      superagent
      .get(Request.urlFor('/me/orgs'))
      .withCredentials()
      .end (err, res) =>
        {orgs} = res.body
        if      orgs.length == 0 then @transitionTo('create-org')
        else if orgs.length == 1 then @transitionTo('workspace', {orgid: orgs[0].id})
        else @transitionTo('select-org')

}

module.exports = LoginModal
