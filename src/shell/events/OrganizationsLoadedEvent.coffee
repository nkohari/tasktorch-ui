Event = require '../../framework/Event'

class OrganizationsLoadedEvent extends Event

  constructor: (@organizations) ->
    super()

module.exports = OrganizationsLoadedEvent
