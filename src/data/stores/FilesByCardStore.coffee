_                         = require 'lodash'
DocumentStatus            = require 'data/enums/DocumentStatus'
ListStore                 = require 'data/framework/ListStore'
LoadFilesByCardRequest    = require 'data/requests/LoadFilesByCardRequest'
RemoveFileFromCardRequest = require 'data/requests/RemoveFileFromCardRequest'

class FilesByCardStore extends ListStore

  displayName: 'FilesByCardStore'
  name:        'filesByCard'
  dependsOn:   'files'

  listensFor: [
    'CardChanged'
    'FilesByCardLoaded'
    'UserRemovedFileFromCard'
  ]

  load: (id) ->
    @execute new LoadFilesByCardRequest(id)

  onCardChanged: (event) ->
    @execute new LoadFilesByCardRequest(event.card.id)

  onFilesByCardLoaded: (event) ->
    files = _.sortBy event.files, (f) -> f.name.toLowerCase()
    @set(event.cardid, _.map(files, 'id'))

  onUserRemovedFileFromCard: (event) ->
    @execute new RemoveFileFromCardRequest(event.cardid, event.fileid)

module.exports = FilesByCardStore
