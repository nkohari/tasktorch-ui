cookies = require 'cookies-js'
Request = require 'framework/Request'

class JoinUserChannelRequest extends Request

  execute: (context, eventBus) ->
    userid = cookies.get('tt-userid')
    eventBus.subscribe("private-user-#{userid}")

module.exports = JoinUserChannelRequest
