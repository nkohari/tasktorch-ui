_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
QueueLoadedEvent = require 'events/load/QueueLoadedEvent'

class LoadMyQueueRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/me/queue?expand=cards", (res) =>
      {stack} = res.body
      cards = _.values(res.body.related.cards)
      eventBus.publish new QueueLoadedEvent(queue, cards)

module.exports = LoadMyQueueRequest
