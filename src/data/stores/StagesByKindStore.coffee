_                        = require 'lodash'
ListStore               = require 'data/framework/ListStore'
LoadStagesByKindRequest = require 'data/requests/LoadStagesByKindRequest'

class StagesByKindStore extends ListStore

  displayName: 'StagesByKindStore'
  name:        'stagesByKind'
  dependsOn:   'stages'

  listensFor: [
    'KindChanged'
    'StagesByKindLoaded'
  ]

  load: (id) ->
    @execute new LoadStagesByKindRequest(id)

  onKindChanged: (event) ->
    @set(event.kind.id, event.kind.stages)

  onStagesByKindLoaded: (event) ->
    @set(event.kindid, _.pluck(event.stages, 'id'))

module.exports = StagesByKindStore
