#--------------------------------------------------------------------------------
React                       = require 'react'
UserChangedOrgDiscountEvent = require 'events/ui/UserChangedOrgDiscountEvent'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
IdentityContext             = require 'ui/framework/mixins/IdentityContext'
Button                      = React.createFactory(require 'ui/common/Button')
Dialog                      = React.createFactory(require 'ui/common/Dialog')
DialogFooter                = React.createFactory(require 'ui/common/DialogFooter')
Field                       = React.createFactory(require 'ui/common/Field')
Input                       = React.createFactory(require 'ui/common/Input')
#--------------------------------------------------------------------------------

ChangeOrgDiscountDialog = React.createClass {

  displayName: 'ChangeOrgDiscountDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: ->
    org = @getCurrentOrg()
    {org, discount: org.discount}

  componentDidMount: ->
    @refs.discount.focus()
    @refs.discount.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Discount', className: 'default', disabled: !@isValid(), onClick: @changeDiscount}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'settings', title: "Redeem Discount for #{@state.org.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Discount Code'},
        Input {ref: 'discount', placeholder: 'Enter a discount code', value: @state.discount, onChange: @onDiscountChanged}

  isValid: ->
    @state.discount?.length > 0

  onDiscountChanged: (event) ->
    @setState {discount: event.target.value}

  changeDiscount: ->
    @publish new UserChangedOrgDiscountEvent(@state.org.id, @state.discount)
    @props.closeDialog()

}

module.exports = ChangeOrgDiscountDialog
