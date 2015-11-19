arrayEnum = require 'common/util/arrayEnum'

module.exports = AccountSubscriptionStatus = arrayEnum [
  'Trial'
  'Active'
  'PastDue'
  'CancellationPending'
  'Canceled'
]
