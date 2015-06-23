#--------------------------------------------------------------------------------
_             = require 'lodash'
superagent    = require 'superagent'
React         = require 'react'
Router        = require 'react-router'
TokenStatus   = require 'data/enums/TokenStatus'
Request       = require 'data/framework/Request'
CreateOrgForm = require 'ui/forms/CreateOrgForm'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
Button        = React.createFactory(require 'ui/common/Button')
Field         = React.createFactory(require 'ui/common/Field')
ModalForm     = React.createFactory(require 'ui/common/ModalForm')
FormButtons   = React.createFactory(require 'ui/common/FormButtons')
Input         = React.createFactory(require 'ui/common/Input')
Modal         = React.createFactory(require 'ui/common/Modal')
ModalMessage  = React.createFactory(require 'ui/common/ModalMessage')
Spinner       = React.createFactory(require 'ui/common/Spinner')
{a, div, p}   = React.DOM
#--------------------------------------------------------------------------------

CreateOrgModal = React.createClass {

  displayName: 'CreateOrgModal'

  propTypes:
    url: PropTypes.object

  mixins: [Router.Navigation]

  getInitialState: -> {
    form: new CreateOrgForm {@onChange}
  }

  render: ->

    buttons = FormButtons {},
      Button {type: 'submit', text: 'Create Organization'}

    Modal {title: 'Create Org', className: 'token-modal'},
      ModalForm {className: 'modal-form', form: @state.form, buttons, @onSubmit}
      ModalMessage {},
        p {}, "You aren't yet a member of an organization. Would you like to create one? "
        p {}, "If someone else that you want to work with has already created an organization, you should ask them for an invitation instead."
        p {},
          "If you need help or have questions, please send us an email at "
          a {href: 'mailto:help@tasktorch.com'}, "help@tasktorch.com"
          "."

  onChange: ->
    @forceUpdate()

  onSubmit: (event) ->

    event.preventDefault()

    isValid = @state.form.validate()
    return unless isValid

    data = @state.form.cleanedData
    
    params = {
      name: data.name
      survey:
        tsp:   data.tsp
        size:  data.size
        role:  data.role
        kinds: data.kinds
    }

    superagent
    .post(Request.urlFor('/orgs'))
    .withCredentials()
    .send(params).end (err, res) =>
      if res.forbidden or res.badRequest
        alert("There was an error creating the organization. Please try again.")
        return
      {org} = res.body
      @transitionTo('send-invites', {orgid: org.id})

}

module.exports = CreateOrgModal
