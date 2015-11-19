Card    = require 'data/models/Card'
Request = require 'data/framework/Request'

class SendInvoiceReceiptRequest extends Request

  constructor: (@orgid, @invoiceid) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/account/invoices/#{@invoiceid}/receipt"))
    .withCredentials()
    .send()

  onSuccess: (result, publish) ->

module.exports = SendInvoiceReceiptRequest
