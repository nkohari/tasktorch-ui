Checklist  = require 'data/models/Checklist'
ModelStore = require 'data/framework/ModelStore'

class ChecklistStore extends ModelStore

  name:        'checklists'
  displayName: 'ChecklistStore'
  modelType:   Checklist

  listensFor: [
    'ChecklistsLoaded'
  ]

  load: (id) ->
    console.warn('ChecklistStore.load() was called')

  onChecklistsLoaded: (event) ->
    @add(event.checklists)

module.exports = ChecklistStore
