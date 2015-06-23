class Request

  @urlFor: (path) ->
    if TASKTORCH_FLAGS_DEBUG
      domain = "https://api.tasktorch.dev:9001"
    else
      domain = "https://api.tasktorch.com"
    return domain + path

  urlFor: (path) ->
    Request.urlFor(path)

  execute: ->
    throw new Error("You must implement execute() on #{@constructor.name}")

module.exports = Request
