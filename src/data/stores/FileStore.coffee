File              = require 'data/models/File'
ModelStore        = require 'data/framework/ModelStore'
LoadFileRequest   = require 'data/requests/LoadFileRequest'
CreateFileRequest = require 'data/requests/CreateFileRequest'

class FileStore extends ModelStore

  displayName: 'FileStore'
  name:        'files'
  modelType:   File

  listensFor: [
    'FilesLoaded'
    'FileCreated'
    'FileChanged'
    'UserCreatedFile'
  ]

  load: (id) ->
    @execute new LoadFileRequest(id)

  onFilesLoaded: (event) ->
    @add(event.files)

  onFileCreated: (event) ->
    @add(event.file)

  onFileChanged: (event) ->
    @add(event.file)

  onUserCreatedFile: (event) ->
    @execute new CreateFileRequest(event.orgid, event.cardid, event.file, event.callbacks)

module.exports = FileStore
