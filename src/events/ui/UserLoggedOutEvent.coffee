Event = require 'events/framework/Event'

class UserLoggedOutEvent extends Event

  type: 'UserLoggedOut'

module.exports = UserLoggedOutEvent
