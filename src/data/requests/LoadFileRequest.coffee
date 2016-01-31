File             = require 'data/models/File'
Request          = require 'data/framework/Request'
FilesLoadedEvent = require 'events/load/FilesLoadedEvent'

class LoadFileRequest extends Request

  constructor: (@fileid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/files/#{@fileid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    file = new File(result.file)
    publish new FilesLoadedEvent([file])

module.exports = LoadFileRequest
