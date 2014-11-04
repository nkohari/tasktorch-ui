ShellController   = require './ShellController'
PresenceStore     = require './stores/PresenceStore'
OrganizationStore = require './stores/OrganizationStore'

ShellEnvironment = {}

ShellEnvironment.createController = ->

  stores =
    organizations: new OrganizationStore()
    presence:      new PresenceStore()

  return new ShellController(stores)

module.exports = ShellEnvironment
