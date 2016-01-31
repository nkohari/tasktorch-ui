_                        = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadStagesByKindRequest = require 'data/requests/LoadStagesByKindRequest'

class StagesByKindStore extends ListStore

  displayName: 'StagesByKindStore'
  name:        'stagesByKind'
  dependsOn:   'stages'

  listensFor: [
    'KindChanged'
    'StageCreated'
    'StagesByKindLoaded'
  ]

  load: (id) ->
    @execute new LoadStagesByKindRequest(id)

  onKindChanged: (event) ->
    @set(event.kind.id, event.kind.stages)

  onStageCreated: (event) ->
    @remove(event.stage.kind)

  onStagesByKindLoaded: (event) ->
    @set(event.kindid, _.map(event.stages, 'id'))

module.exports = StagesByKindStore
