#--------------------------------------------------------------------------------
_              = require 'lodash'
superagent     = require 'superagent'
React          = require 'react'
Router         = require 'react-router'
InviteStatus   = require 'data/enums/InviteStatus'
Request        = require 'data/framework/Request'
CreateUserForm = require 'ui/forms/CreateUserForm'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Button         = React.createFactory(require 'ui/common/Button')
Field          = React.createFactory(require 'ui/common/Field')
ModalForm      = React.createFactory(require 'ui/common/ModalForm')
FormButtons    = React.createFactory(require 'ui/common/FormButtons')
Input          = React.createFactory(require 'ui/common/Input')
Modal          = React.createFactory(require 'ui/common/Modal')
ModalMessage   = React.createFactory(require 'ui/common/ModalMessage')
Spinner        = React.createFactory(require 'ui/common/Spinner')
{a, div, p, span, strong} = React.DOM
#--------------------------------------------------------------------------------

AcceptInviteModal = React.createClass {

  displayName: 'AcceptInviteModal'

  propTypes:
    params: PropTypes.object

  mixins: [CachedState, Router.History]

  getInitialState: ->
    {form: new CreateUserForm {@onChange}}

  getCachedState: (cache) ->
    {invite: cache('invites').get(@props.params.inviteid)}

  render: ->

    Modal {title: 'Accept Invitation', className: 'accept-invite-modal'},
      @renderForm()
      @renderMessage()

  renderForm: ->
    return unless @state.invite?.status is InviteStatus.Pending

    note = div {className: 'form-note'},
      'By signing up, you agree that you have read and consent to our '
      a {href: 'http://support.tasktorch.com/articles/terms.html', target: '_blank'}, 'terms of service'
      ' and '
      a {href: 'http://support.tasktorch.com/articles/privacy.html', target: '_blank'}, 'privacy policy'
      '.'

    buttons = FormButtons {},
      Button {type: 'submit', text: 'Sign Up'}
      span {className: 'divider'}, "or "
      a {onClick: @onLoginClicked}, "I already have an account"

    ModalForm {form: @state.form, note, buttons, @onSubmit}

  renderMessage: ->
    if not @state.invite?
      ModalMessage {},
        p {},
          Spinner {size: 16}
          "Please wait a second while I find your invitation."
    else if @state.invite.status isnt InviteStatus.Pending
      ModalMessage {},
        p {},
          "Sorry, it looks like that invitation has already been accepted. "
          "Please ask a leader of the organization to send you another invitiation."
        p {},
          "If you already accepted it, you can "
          a {onClick: @onLoginClicked}, "log in"
          "."
        p {},
          "If you need help or have questions, please send us an email at "
          a {href: 'mailto:help@tasktorch.com'}, "help@tasktorch.com"
          "."
    else
      ModalMessage {},
        p {},
          "Hey, it looks like you've got an invitation to join "
          strong {}, @state.invite.orgName
          " on TaskTorch. Lucky you!"
        p {}, "TaskTorch is a task management and collaboration platform that puts you in control of your own work and helps you work more effectively with your teammates."
        p {}, "Just give us a little information about yourself and we'll get you signed up!"

  onChange: ->
    @forceUpdate()

  onLoginClicked: ->
    @history.pushState(null, '/x/login', {from: 'invite', invite: @state.invite.id})

  onSubmit: (event) ->

    event.preventDefault()

    @state.form.validate (err, isValid) =>
      return if err? or not isValid

      {username, name, email, password} = @state.form.cleanedData

      params = {
        username: username
        name:     name
        email:    email
        password: password
        invite:   @state.invite.id
      }

      superagent
      .post(Request.urlFor('/users'))
      .send(params)
      .withCredentials()
      .end (err, res) =>
        if res.forbidden or res.badRequest
          alert("There was an error creating your account. Please try again.")
          return
        @history.pushState(null, '/x/login', {from: 'invite-accepted'})

}

module.exports = AcceptInviteModal