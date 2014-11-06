WorkspaceController      = require './WorkspaceController'
CardStore                = require './stores/CardStore'
OrganizationStore        = require './stores/OrganizationStore'
StackStore               = require './stores/StackStore'
TeamStore                = require './stores/TeamStore'
TypeStore                = require './stores/TypeStore'
UserStore                = require './stores/UserStore'
CardBodyChangedListener  = require './listeners/CardBodyChangedListener'
CardTitleChangedListener = require './listeners/CardTitleChangedListener'

WorkspaceEnvironment = {}

WorkspaceEnvironment.createController = ->

  stores =
    cards:         new CardStore()
    organizations: new OrganizationStore()
    stacks:        new StackStore()
    teams:         new TeamStore()
    types:         new TypeStore()
    users:         new UserStore()

  window._store = stores.stacks

  listeners = [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
  ]

  return new WorkspaceController(stores, listeners)

module.exports = WorkspaceEnvironment
