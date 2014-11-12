_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
QueueLoadedEvent = require 'events/QueueLoadedEvent'

class LoadMyQueueRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/me/queue?expand=cards", (res) =>
      queue = _.omit(res.body, '_related')
      cards = res.body['_related'].cards
      eventBus.publish new QueueLoadedEvent(queue, cards)

module.exports = LoadMyQueueRequest
