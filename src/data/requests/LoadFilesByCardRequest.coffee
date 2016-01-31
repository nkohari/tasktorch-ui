_                      = require 'lodash'
Request                = require 'data/framework/Request'
File                   = require 'data/models/File'
FilesLoadedEvent       = require 'events/load/FilesLoadedEvent'
FilesByCardLoadedEvent = require 'events/load/FilesByCardLoadedEvent'

class LoadFilesByCardRequest extends Request

  constructor: (@cardid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/cards/#{@cardid}/files"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    files = _.map result.files, (data) -> new File(data)
    publish new FilesLoadedEvent(files)
    publish new FilesByCardLoadedEvent(@cardid, files)

module.exports = LoadFilesByCardRequest
