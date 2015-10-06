PropTypes = require 'ui/framework/PropTypes'

Actor = {

  contextTypes:
    environment: PropTypes.object

  componentWillMount: ->
    return unless @listensFor?
    eventQueue = @_getEventQueue()
    for type in @listensFor
      func = "on#{type}"
      unless this[func]?
        debug.error("Missing event handler definition #{func}() on #{@constructor.displayName}")
      eventQueue.addListener(type, this[func])

  componentDidUnmount: ->
    return unless @listensFor?
    eventQueue = @_getEventQueue()
    for type in @listensFor
      eventQueue.removeListener(type, this["on#{type}"])

  publish: (event) ->
    @_getEventQueue().publish(event)

  _getEventQueue: ->
    @context.environment.get('eventQueue')

}

module.exports = Actor
