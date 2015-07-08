Stage                            = require 'data/models/Stage'
ModelStore                       = require 'data/framework/ModelStore'
LoadStageRequest                 = require 'data/requests/LoadStageRequest'
DeleteStageRequest               = require 'data/requests/DeleteStageRequest'
RenameStageRequest               = require 'data/requests/RenameStageRequest'
ChangeStageDefaultActionsRequest = require 'data/requests/ChangeStageDefaultActionsRequest'

class StageStore extends ModelStore

  displayName: 'StageStore'
  name:        'stages'
  modelType:   Stage

  listensFor: [
    'StagesLoaded'
    'StageCreated'
    'StageChanged'
    'UserChangedStageDefaultActions'
    'UserDeletedStage'
    'UserRenamedStage'
  ]

  load: (id) ->
    @execute new LoadStageRequest(id)

  onStagesLoaded: (event) ->
    @add(event.stages)

  onStageChanged: (event) ->
    @add(event.stage)

  onStageCreated: (event) ->
    @add(event.stage)

  onUserChangedStageDefaultActions: (event) ->
    @execute new ChangeStageDefaultActionsRequest(event.stageid, event.defaultActions)

  onUserDeletedStage: (event) ->
    @execute new DeleteStageRequest(event.stageid, event.inheritorStage)

  onUserRenamedStage: (event) ->
    @execute new RenameStageRequest(event.stageid, event.name)

module.exports = StageStore
