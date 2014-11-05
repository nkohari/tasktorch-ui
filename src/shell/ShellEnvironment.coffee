ShellController          = require './ShellController'
QueueStore               = require './stores/QueueStore'
PresenceStore            = require './stores/PresenceStore'
OrganizationStore        = require './stores/OrganizationStore'
CardBodyChangedListener  = require './listeners/CardBodyChangedListener'
CardTitleChangedListener = require './listeners/CardTitleChangedListener'

ShellEnvironment = {}

ShellEnvironment.createController = ->

  stores =
    queue:         new QueueStore()
    organizations: new OrganizationStore()
    presence:      new PresenceStore()

  listeners = [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
  ]

  return new ShellController(stores, listeners)

module.exports = ShellEnvironment
