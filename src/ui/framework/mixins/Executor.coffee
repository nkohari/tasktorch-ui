NOOP = (->)

Executor = {

  execute: (request, callback = NOOP) ->
    request.execute(Environment.eventQueue)

}

module.exports = Executor
