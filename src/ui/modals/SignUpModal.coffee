#--------------------------------------------------------------------------------
_              = require 'lodash'
superagent     = require 'superagent'
React          = require 'react'
Router         = require 'react-router'
Request        = require 'data/framework/Request'
CreateUserForm = require 'ui/forms/CreateUserForm'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
Field          = React.createFactory(require 'ui/common/Field')
ModalForm      = React.createFactory(require 'ui/common/ModalForm')
FormButtons    = React.createFactory(require 'ui/common/FormButtons')
Input          = React.createFactory(require 'ui/common/Input')
Modal          = React.createFactory(require 'ui/common/Modal')
ModalMessage   = React.createFactory(require 'ui/common/ModalMessage')
Spinner        = React.createFactory(require 'ui/common/Spinner')
{a, div, p}    = React.DOM
#--------------------------------------------------------------------------------

SignUpModal = React.createClass {

  displayName: 'SignUpModal'

  propTypes:
    params: PropTypes.object

  mixins: [Router.History]

  getInitialState: -> {
    form: new CreateUserForm {@onChange}
  }

  render: ->

    Modal {title: 'Sign Up', className: 'token-modal'},
      @renderForm()
      @renderMessage()

  renderForm: ->
    note = div {className: 'form-note'},
      'By signing up, you agree that you have read and consent to our '
      a {href: 'http://support.tasktorch.com/articles/terms.html', target: '_blank'}, 'terms of service'
      ' and '
      a {href: 'http://support.tasktorch.com/articles/privacy.html', target: '_blank'}, 'privacy policy'
      '.'

    buttons = FormButtons {},
      Button {type: 'submit', text: 'Sign Up'}

    ModalForm {className: 'modal-form', form: @state.form, note, buttons, @onSubmit}

  renderMessage: ->
    ModalMessage {},
      p {}, "Welcome to TaskTorch! "
      p {}, "TaskTorch is a task management and collaboration platform that puts you in control of your own work and helps you work more effectively with your teammates."
      p {}, "First, we just need a little information about you, and then we can create your organization and invite others to work with you."

  onChange: ->
    @forceUpdate()

  onLoginClicked: ->
    @history.pushState(null, '/login')

  onSubmit: (event) ->

    @state.form.validate (err, isValid) =>
      return if err? or not isValid

      {username, name, email, password} = @state.form.cleanedData

      params = {
        username: username
        name:     name
        email:    email
        password: password
      }

      superagent
      .post(Request.urlFor('/users'))
      .send(params).end (err, res) =>
        if res.forbidden or res.badRequest
          alert("There was an error creating your account. Please try again.")
          return
        @history.pushState(null, '/login', {from: 'signup'})

    event.preventDefault()

}

module.exports = SignUpModal
