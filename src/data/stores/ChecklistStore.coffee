Checklist  = require 'data/models/Checklist'
ModelStore = require 'data/framework/ModelStore'

class ChecklistStore extends ModelStore

  name:        'checklists'
  displayName: 'ChecklistStore'
  modelType:   Checklist

  listensFor: [
    'ChecklistsLoaded'
    'ChecklistChanged'
  ]

  load: (id) ->
    console.warn('ChecklistStore.load() was called')

  onChecklistsLoaded: (event) ->
    @add(event.checklists)

  onChecklistChanged: (event) ->
    @add(event.checklist)

module.exports = ChecklistStore
