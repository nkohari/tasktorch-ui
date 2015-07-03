arrayEnum = require 'common/util/arrayEnum'

module.exports = CardStatus = arrayEnum [
  'NotStarted'
  'InProgress'
  'Warning'
  'Idle'
  'Complete'
  'Deleted'
]
