Actor = {

  componentWillMount: ->
    if @listensFor?
      for type in @listensFor
        func = "on#{type}"
        unless this[func]?
          console.warn("Missing event handler definition #{func}() on #{@constructor.displayName}")
        Environment.eventQueue.addListener(type, this[func])

  componentDidUnmount: ->
    if @listensFor?
      for type in @listensFor
        Environment.eventQueue.removeListener(type, this["on#{type}"])

  publish: (event) ->
    Environment.eventQueue.publish(event)

}

module.exports = Actor
