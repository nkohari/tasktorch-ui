WorkspaceController = require './WorkspaceController'
CardStore           = require './stores/CardStore'
OrganizationStore   = require './stores/OrganizationStore'
StackStore          = require './stores/StackStore'
TeamStore           = require './stores/TeamStore'
TypeStore           = require './stores/TypeStore'
UserStore           = require './stores/UserStore'

WorkspaceControllerFactory = {}

WorkspaceControllerFactory.create = (eventBus) ->

  new WorkspaceController eventBus,
    cards:         new CardStore()
    organizations: new OrganizationStore()
    stacks:        new StackStore()
    teams:         new TeamStore()
    types:         new TypeStore()
    users:         new UserStore()

module.exports = WorkspaceControllerFactory
