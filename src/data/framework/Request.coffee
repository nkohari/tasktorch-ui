class Request

  @urlFor: (path) ->
    if process.env['NODE_ENV'] == 'production'
      domain = "https://api.tasktorch.com"
    else
      domain = "https://api.tasktorch.dev:9001"
    return domain + path

  urlFor: (path) ->
    Request.urlFor(path)

  execute: ->
    throw new Error("You must implement execute() on #{@constructor.name}")

module.exports = Request
