class Request

  @urlFor: (path) ->
    if TASKTORCH_FLAGS_DEBUG
      domain = "https://api.tasktorch.dev:9001"
    else
      domain = "https://api.tasktorch.com"
    return domain + path

  urlFor: (path) ->
    Request.urlFor(path)

  create: ->
    throw new Error("You must implement create() on #{@constructor.name}")

  onSuccess: ->
    throw new Error("You must implement onSuccess() on #{@constructor.name}")    

  onNotFound: ->
    throw new Error("You must implement onNotFound() on #{@constructor.name}")    

  onForbidden: ->
    throw new Error("You must implement onForbidden() on #{@constructor.name}")    

  onError: ->
    throw new Error("You must implement onError() on #{@constructor.name}")    

module.exports = Request
