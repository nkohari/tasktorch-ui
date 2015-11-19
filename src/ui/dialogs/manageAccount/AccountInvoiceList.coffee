#--------------------------------------------------------------------------------
_                                      = require 'lodash'
React                                  = require 'react'
UserRequestedInvoiceReceiptEvent       = require 'events/ui/UserRequestedInvoiceReceiptEvent'
PropTypes                              = require 'ui/framework/PropTypes'
Actor                                  = require 'ui/framework/mixins/Actor'
CachedState                            = require 'ui/framework/mixins/CachedState'
Button                                 = React.createFactory(require 'ui/common/Button')
Currency                               = React.createFactory(require 'ui/common/Currency')
Icon                                   = React.createFactory(require 'ui/common/Icon')
Time                                   = React.createFactory(require 'ui/common/Time')
Spinner                                = React.createFactory(require 'ui/common/Spinner')
{div, table, thead, tbody, tr, th, td} = React.DOM
#--------------------------------------------------------------------------------
require './AccountInvoiceList.styl'
#--------------------------------------------------------------------------------

AccountInvoiceList = React.createClass {

  displayName: 'AccountInvoiceList'

  propTypes:
    org: PropTypes.Org

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    {invoices: cache('invoicesByOrg').get(@props.org.id)}

  render: ->

    unless @state.invoices?
      return div {className: 'account-invoice-list'},
        Spinner {}
        'Loading invoices'

    invoices = _.map(@state.invoices, @renderInvoice)
    div {className: 'account-invoice-list'},
      table {},
        thead {},
          th {}
          th {}, "Date"
          th {}, "Amount"
          th {}
        tbody {},
          invoices

  renderInvoice: (invoice) ->

    tr {key: invoice.id, className: 'account-invoice'},
      td {className: 'status'},
        Icon {name: 'success'}
      td {className: 'date'},
        Time {time: invoice.timestamp, format: 'MMMM DD, YYYY'}
      td {className: 'amount'},
        Currency {value: invoice.amount}
      td {className: 'receipt'},
        Button {className: 'small', text: 'Re-send Receipt', onClick: @resendReceipt.bind(this, invoice)}

  resendReceipt: (invoice) ->
    @publish new UserRequestedInvoiceReceiptEvent(invoice.org, invoice.id)

}

module.exports = AccountInvoiceList
