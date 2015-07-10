Stage                            = require 'data/models/Stage'
ModelStore                       = require 'data/framework/ModelStore'
LoadStageRequest                 = require 'data/requests/LoadStageRequest'
CreateStageRequest               = require 'data/requests/CreateStageRequest'
DeleteStageRequest               = require 'data/requests/DeleteStageRequest'
MoveStageRequest                 = require 'data/requests/MoveStageRequest'
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
    'UserCreatedStage'
    'UserChangedStageDefaultActions'
    'UserDeletedStage'
    'UserMovedStage'
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

  onUserCreatedStage: (event) ->
    @execute new CreateStageRequest(event.kindid, event.name)

  onUserChangedStageDefaultActions: (event) ->
    @execute new ChangeStageDefaultActionsRequest(event.stageid, event.defaultActions)

  onUserDeletedStage: (event) ->
    @execute new DeleteStageRequest(event.stageid, event.inheritorStage)

  onUserMovedStage: (event) ->
    @execute new MoveStageRequest(event.stageid, event.position)

  onUserRenamedStage: (event) ->
    @execute new RenameStageRequest(event.stageid, event.name)

module.exports = StageStore
