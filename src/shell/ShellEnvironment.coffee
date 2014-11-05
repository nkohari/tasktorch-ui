ShellController          = require './ShellController'
FocusedCardStore         = require './stores/FocusedCardStore'
PresenceStore            = require './stores/PresenceStore'
OrganizationStore        = require './stores/OrganizationStore'
CardBodyChangedListener  = require './listeners/CardBodyChangedListener'
CardTitleChangedListener = require './listeners/CardTitleChangedListener'

ShellEnvironment = {}

ShellEnvironment.createController = ->

  stores =
    focus:         new FocusedCardStore()
    organizations: new OrganizationStore()
    presence:      new PresenceStore()

  listeners = [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
  ]

  return new ShellController(stores, listeners)

module.exports = ShellEnvironment
