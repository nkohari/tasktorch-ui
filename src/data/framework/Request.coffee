class Request

  execute: ->
    throw new Error("You must implement execute() on #{@constructor.name}")

module.exports = Request
