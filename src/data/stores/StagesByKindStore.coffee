_                        = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadStagesByKindRequest = require 'data/requests/LoadStagesByKindRequest'

class StagesByKindStore extends ListStore

  displayName: 'StagesByKindStore'
  name:        'stagesByKind'
  dependsOn:   'stages'

  listensFor: [
    'KindChanged'
    'StageChanged'
    'StageCreated'
    'StagesByKindLoaded'
  ]

  load: (id) ->
    @execute new LoadStagesByKindRequest(id)

  onKindChanged: (event) ->
    @set(event.kind.id, event.kind.stages)

  onStageChanged: (event) ->
    @remove(event.stage.kind)

  onStageCreated: (event) ->
    @remove(event.stage.kind)

  onStagesByKindLoaded: (event) ->
    @set(event.kindid, _.pluck(event.stages, 'id'))

module.exports = StagesByKindStore
