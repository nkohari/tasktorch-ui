ShellController   = require './ShellController'
GoalStore         = require './stores/GoalStore'
QueueStore        = require './stores/QueueStore'
PresenceStore     = require './stores/PresenceStore'
OrganizationStore = require './stores/OrganizationStore'

ShellControllerFactory = {}

ShellControllerFactory.create = (organizationId, eventBus) ->

  new ShellController(organizationId, eventBus, {
    goals:         new GoalStore()
    queue:         new QueueStore()
    presence:      new PresenceStore()
    organizations: new OrganizationStore()
  })

module.exports = ShellControllerFactory
