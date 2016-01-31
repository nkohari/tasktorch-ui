_                = require 'lodash'
File             = require 'data/models/File'
FileCreatedEvent = require 'events/create/FileCreatedEvent'
Request          = require 'data/framework/Request'

class CreateFileRequest extends Request

  constructor: (@orgid, @cardid, @file, @callbacks) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/files"))
    .field('card', @cardid)
    .attach('file', @file, @file.name)
    .on('progress', @onProgress.bind(this))
    .on('response', @onComplete.bind(this))
    .withCredentials()

  onSuccess: (result, publish, agent) ->
    {file} = result
    file = new File(file)
    publish new FileCreatedEvent(file)

  onProgress: (event) ->
    # Only announce progress for the file upload, not the rest of the form data
    return unless event.currentTarget instanceof XMLHttpRequestUpload
    @callbacks.onProgress(event) if @callbacks.onProgress?

  onComplete: (response) ->
    @callbacks.onComplete() if @callbacks.onComplete?


module.exports = CreateFileRequest
