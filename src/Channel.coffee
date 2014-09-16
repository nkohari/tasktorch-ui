_ = require 'lodash'

class Channel

  constructor: (@name) ->
    @subscribers = []

  subscribe: (subscriber) ->
    @subscribers.push(subscriber) unless _.contains(@subscribers, subscriber)

  unsubscribe: (subscriber) ->
    @subscribers = _.without(@subscribers, subscriber) if @subscribers?

  announce: (data) ->
    _.each @subscribers, (subscriber) -> subscriber.dataDidChange(data)

module.exports = Channel
