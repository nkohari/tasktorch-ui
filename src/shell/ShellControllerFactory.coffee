ShellController   = require './ShellController'
QueueStore        = require './stores/QueueStore'
PresenceStore     = require './stores/PresenceStore'
OrganizationStore = require './stores/OrganizationStore'

ShellControllerFactory = {}

ShellControllerFactory.create = ->

  new ShellController
    queue:         new QueueStore()
    presence:      new PresenceStore()
    organizations: new OrganizationStore()

module.exports = ShellControllerFactory
